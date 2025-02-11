{
  # pkgs ? import <nixpkgs> {},
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.gameserver.webapp;
in {
  ## OPTIONS
  options.gameserver.webapp = {
    enable = lib.mkEnableOption "Enable Webapp";
    gameTitle = lib.mkOption {
      type = lib.types.str;
      default = "GAME";
      description = "server game name to display. on webapp";
    };
    serverHost = lib.mkOption {
      type = lib.types.str;
      default = "10.233.1.2";
      description = "Game server ip address";
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
                $server_host = '${cfg.serverHost}';
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
  };
}
