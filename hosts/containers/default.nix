{pkgs, ...}: {
  imports = [
    ./base_server.nix
  ];

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "adminer" "${pkgs.php}/bin/php -S 'localhost:8000' -t ${pkgs.adminer}/ &
    xdg-open 'localhost:8000/adminer.php'")
  ];

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
    };
  };
}
