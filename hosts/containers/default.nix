{
  pkgs,
  lib,
  nixpkgs2111,
  ...
}: {
  imports = [
    ./base_server.nix
  ];

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "adminer" "${pkgs.php}/bin/php -S 'localhost:8000' -t ${pkgs.adminer}/ &
    xdg-open 'localhost:8000/adminer.php'")
    (writers.writeBashBin "findIp" ''
      LC_ALL=C

      # bin_folder="$1"
      output_lines="$1"
      # echo "$bin_folder || $output_lines"
      binFiles=$(find . -type f -name "*Server")
      for file in $binFiles ; do
          matches=$(grep -robaUP --color "[\x30-\x39]{2,3}\.([\x30-\x39]{1,3}\.){1,2}([\x30-\x39]{1,3}){0,1}" "$file")
          printf "\033[1;33mFile: \033[1;36m %s \033[0m\n" "$file"
          echo "$matches" | awk -F: '{printf "\033[1;32m%X\033[1;34m:\033[31m%s\033[0m\n", $1, $2}' | head -n "$output_lines"
      done
    '')
  ];
  #NOTE: use this grep command to get the patch address
  # grep -obaUP --color "[\x30-\x39]{2,3}\.([\x30-\x39]{1,3}\.){1,2}([\x30-\x39]{1,3}){0,1}" LoginServer/LoginServer | awk -F: '{printf "\033[1;32m%X\033[1;34m:\033[31m%s\n", $1, $2}'
  #
  gameserver = {
    dsoServer = {
      enable = true;
      gameTitle = "Dragomon Hunters";
      # serverName = "dsoServer";
      serverFiles = "/home/ovo/Documents/dso_server/";
      hostAddress = "192.168.1.1";
      serverAddress = "192.168.1.55";
      dbAccountDBName = "ds_account";
      dbMembersDBName = "ds_member";
      dbGatewayDBName = "ds_gateway";
      webapp = {
        enable = true;
      };
      patchInfo = {};
    };

    gfServer = {
      enable = true;
      gameTitle = "Grand Fantasia";
      # serverName = "gfServer";
      serverFiles = "/home/ovo/Documents/gf_server/";
      hostAddress = "10.233.1.1";
      serverAddress = "10.233.1.2";
      dbAccountDBName = "gf_ls";
      dbMembersDBName = "gf_gs";
      dbGatewayDBName = "gf_ms";
      webapp = {
        enable = true;
      };
      patchInfo = {
        LoginServer = {
          local = ["14D1FA"];
          global = ["152007"];
        };
        WorldServer = {
          local = ["45EC2C"];
          global = ["4BE759"];
        };
        ZoneServer = {
          global = ["9EE22D"];
        };
        TicketServer = {
          global = ["11B74B"];
        };
        MissionServer = {
          global = ["57F66D"];
        };
        GatewayServer = {
          global = ["16AE07"];
        };
      };
    };

    arServer = {
      enable = true;
      gameTitle = "Astral Realm";
      # serverName = "dsoServer";
      serverFiles = "/home/ovo/Documents/ar_server/";
      hostAddress = "192.168.1.1";
      serverAddress = "192.168.1.20";
      # dbAccountDBName = "ds_account";
      # dbMembersDBName = "ds_member";
      # dbGatewayDBName = "ds_gateway";
      numberOfChannels = "3";
      webapp = {
        enable = true;
      };
      patchInfo = {};
    };
  };
  ## TODO: COMMENT AFTER DONE CONVERTING FROM POSTGRES_9

  containers.postgres9 = let
    system = "x86_64-linux";
    oldPkgs = import (builtins.fetchTarball {
      # url = "https://github.com/NixOS/nixpkgs/archive/cb3f4892e93588e951b3ac27be1a01f71e5579b0.tar.gz"; # nixos-24.05
      # sha256 = "sha256:0aiw15hkpisjapi62z47h2l4fpf298h5x27wlcwj0fqk9in27jrr";
      # url = "https://github.com/NixOS/nixpkgs/archive/fadaef5aedb6b35681248f8c6096083b2efeb284.tar.gz";# nixos-unstable
      # sha256 = "sha256:1if9fmx0zpx243jgp7vzkh6r5ai7ym8v7779yyq3x14bnqvax4fh";
      url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/21.11.tar.gz";
      sha256 = "sha256:162dywda2dvfj1248afxc45kcrg83appjd0nmdb541hl7rnncf02";
    }) {inherit system;};
    postgresql_9 = oldPkgs.postgresql_9_6.overrideAttrs (oldAttrs: {
      withoutJIT = oldPkgs.postgresql_9_6;
    });
  in {
    timeoutStartSec = "5min";
    privateNetwork = true;
    hostAddress = "192.168.2.1";
    localAddress = "192.168.2.44";
    autoStart = false;
    hostBridge = null;
    bindMounts = {
      "/root/server/" = {
        hostPath = "/home/ovo/Documents/ar_server";
        isReadOnly = false;
      };
    };
    config = {
      config,
      pkgs,
      lib,
      ...
    }: let
      cfg = config.services.postgresql;
    in {
      boot.isContainer = true;
      networking.hostName = lib.mkDefault "postgres9";
      networking.useDHCP = false;
      networking.firewall.allowedTCPPorts = [
        5432
      ];
      services.postgresql = {
        enable = true;
        package = postgresql_9;

        settings = lib.mkForce {
          hba_file = "${pkgs.writeText "pg_hba.conf" cfg.authentication}";
          ident_file = "${pkgs.writeText "pg_ident.conf" cfg.identMap}";
          # jit = 'off'
          listen_addresses = "*";
          log_destination = "csvlog";
          log_directory = "pg_log";
          log_line_prefix = "[%p] ";
          logging_collector = "on";
          port = 5432;
        };

        # set postgres user password
        initialScript = pkgs.writeText "init-sql-script" ''
          alter user postgres with password 'password';
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

      system.stateVersion = "21.11";
    };
  };
}
