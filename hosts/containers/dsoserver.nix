# use Beekeeper(free+OpenSource) for database manipulation
{
  pkgs,
  lib,
  ...
}: let
  game_name = "'Dragonmon Hunters'";
  server_host = "'192.168.1.55'";
  db_user = "'postgres'";
  db_password = "'password'";

  db_members = "'ds_member'";
  db_account = "'ds_account'";
  db_gateway = "'ds_gateway'";
  # login_port = 6543;
in {
  # boot.isContainer = true;
  #
  # networking.hostName = lib.mkDefault "gfServer";
  # networking.useDHCP = false;
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
    # package = pkgs.postgresql;
    settings = {
      logging_collector = lib.mkForce "on";
      log_directory = lib.mkForce "pg_log";
      log_destination = lib.mkForce "csvlog";
      listen_addresses = lib.mkForce "*";
    };
    # for testing only
    initialScript = pkgs.writeText "init-sql-script" ''
      alter user postgres with password '${db_password}';
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

  services.httpd = let
    webapp = import ./gfwebpage_drv.nix {
      inherit pkgs;
      inherit game_name;
      inherit server_host;
      inherit db_user;
      inherit db_password;
      inherit db_members;
      inherit db_account;
      inherit db_gateway;
      # inherit login_port;
    };
  in {
    enable = true;
    enablePHP = true;
    phpPackage = pkgs.php81;
    virtualHosts.localhost = {
      documentRoot = webapp.source-code;
      # documentRoot = "/root/gf_server/_utils/web/";
    };
  };

  environment.shellAliases = {
    server-watch = "watch 'ps aux | grep Server'";
    server-ports = "watch 'ss -ltu4n'";
  };

  environment.systemPackages = with pkgs; [
    # php81
    # php81Extensions.pgsql
    killall
    perl
  ];

  system.stateVersion = "24.11";
}
