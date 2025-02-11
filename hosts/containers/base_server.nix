{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.gameserver.server;
in {
  ## OPTIONS
  options.gameserver.server = {
    enable = lib.mkEnableOption "Enable Game Server";
    webapp.enable = lib.mkEnableOption "Enable Webapp";
    serverName = lib.mkOption {
      type = lib.types.str;
      default = "server";
      description = "server name for container to display, use camelCase.";
    };
    gameTitle = lib.mkOption {
      type = lib.types.str;
      default = "GAME";
      description = "server game name to display. on webapp";
    };
    hostAddress = lib.mkOption {
      type = lib.types.str;
      default = "10.233.1.1";
      description = "Host ip address ";
    };
    serverAddress = lib.mkOption {
      type = lib.types.str;
      default = "10.233.1.2";
      description = "Game server(container) ip address";
    };
    serverFiles = lib.mkOption {
      type = lib.types.str;
      default = "/home/servers/server";
      description = "Game server files location";
    };
    dbUserName = lib.mkOption {
      type = lib.types.str;
      default = "postgres";
      description = "database username to use";
    };
    dbPassword = lib.mkOption {
      type = lib.types.str;
      default = "password";
      description = "database username's password to use";
    };
    dbMembersDBName = lib.mkOption {
      type = lib.types.str;
      default = "MembersDB";
      description = "Member database name to use";
    };
    dbAccountDBName = lib.mkOption {
      type = lib.types.str;
      default = "AccountDB";
      description = "Account database name to use";
    };
    dbGatewayDBName = lib.mkOption {
      type = lib.types.str;
      default = "GatewayDB";
      description = "Gateway database name to use";
    };
  };

  ## CONFIGURATIONS
  config = lib.mkIf cfg.enable {
    containers.${cfg.serverName} = {
      timeoutStartSec = "5min";
      privateNetwork = true;
      hostAddress = "${cfg.hostAddress}";
      localAddress = "${cfg.serverAddress}";
      autoStart = false;
      hostBridge = null;
      bindMounts = {
        "/root/server/" = {
          hostPath = "${cfg.serverFiles}";
          isReadOnly = false;
        };
      };
      config = lib.mkMerge [
        {
          boot.isContainer = true;
          networking.hostName = lib.mkDefault "${cfg.serverName}";
          networking.useDHCP = false;
          networking.firewall.allowedTCPPorts = [
            80
            5432
            6543
            5560
            7777
            7654
            ####
            5517
            5518
            5527
            5528
            5597
            5598
            ####
            10321
            10322
            10329
            10010
            10020
            10090
            20061
            20062
            20069
          ];

          services.postgresql = {
            enable = true;
            package = pkgs.postgresql_13;
            settings = {
              logging_collector = lib.mkForce "on";
              log_directory = lib.mkForce "pg_log";
              log_destination = lib.mkForce "csvlog";
              listen_addresses = lib.mkForce "*";
            };
            # set postgres user password
            initialScript = pkgs.writeText "init-sql-script" ''
              alter user postgres with password '${cfg.dbPassword}';
            '';

            authentication = lib.mkForce ''
              # Generated file; do not edit!
              # TYPE  DATABASE        USER            ADDRESS                 METHOD
              local   all             all                                     trust
              host    all             all             0.0.0.0/0               md5
              host    all             all               ::/0                  md5
              # Allow replication connections from localhost, by a user with the
              # replication privilege.
              local   replication     all                                     trust
              host    replication     all             0.0.0.0/0               md5
              host    replication     all             ::0/0                   md5
            '';
          };

          environment.shellAliases = {
            server-watch = "watch 'ps aux | grep Server'";
            server-ports = "watch 'ss -ltu4n'";
          };

          environment.systemPackages = with pkgs; [
            killall
            perl
          ];
          system.stateVersion = "24.11";
        }

        (lib.mkIf cfg.webapp.enable {
          services.httpd = let
            source-code = pkgs.stdenv.mkDerivation {
              name = "webapp-php";

              src = ./webapp;

              config_file =
                pkgs.writeText "config.php"
                /*
                php
                */
                ''
                  <?php
                      $server_host = '${cfg.serverAddress}';
                      $db_user = '${cfg.dbUserName}';
                      $db_password = '${cfg.dbPassword}';
                      $game_name = '${cfg.gameTitle}';

                      $db_members = '${cfg.dbMembersDBName}';
                      $db_account = '${cfg.dbAccountDBName}';
                      $db_gateway = '${cfg.dbGatewayDBName}';

                      $login_port = 6543;

                      $db_gs = pg_connect("host=$server_host dbname=$db_members user=$db_user password=$db_password");
                      $db_ls = pg_connect("host=$server_host dbname=$db_account user=$db_user password=$db_password");
                      $db_ms = pg_connect("host=$server_host dbname=$db_gateway user=$db_user password=$db_password");
                  ?>
                '';

              phases = ["installPhase"];
              installPhase = ''
                mkdir $out
                cp $config_file $out/config.php
                cp -r $src/* $out
              '';
            };
          in {
            enable = true;
            enablePHP = true;
            phpPackage = pkgs.php81;
            virtualHosts.localhost = {
              documentRoot = source-code;
            };
          };
        })
      ];
    };
  };
}
