# use Beekeeper(free+OpenSource) for database manipulation
{
  pkgs,
  lib,
  ...
}: let
  db_pwd = "password";
in {
  # boot.isContainer = true;
  #
  # networking.hostName = lib.mkDefault "gfServer";
  # networking.useDHCP = false;
  networking.firewall.allowedTCPPorts = [80 5432 6543 5560 7777 7654];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
    settings = {
      logging_collector = lib.mkForce "on";
      log_directory = lib.mkForce "pg_log";
      log_destination = lib.mkForce "csvlog";
      listen_addresses = lib.mkForce "*";
    };
    # for testing only
    initialScript = pkgs.writeText "init-sql-script" ''
      alter user postgres with password '${db_pwd}';
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
    webapp = import ./gfwebpage_drv.nix {inherit pkgs;};
  in {
    enable = true;
    enablePHP = true;
    phpPackage = pkgs.php;
    virtualHosts.localhost = {
      documentRoot = webapp.source-code;
      # documentRoot = "/root/gf_server/_utils/web/";
    };
  };

  environment.systemPackages = with pkgs; [
    php83
    php83Extensions.pgsql
  ];

  system.stateVersion = "24.11";
}
