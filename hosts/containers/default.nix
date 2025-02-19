{pkgs, ...}: {
  imports = [
    ./base_server.nix
  ];

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "adminer" "${pkgs.php}/bin/php -S 'localhost:8000' -t ${pkgs.adminer}/ &
    xdg-open 'localhost:8000/adminer.php'")
    (writers.writeBashBin "findIp" ''

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
      webapp = {
        enable = true;
      };
      patchInfo = {};
    };
  };
}
