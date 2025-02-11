{...}: {
  imports = [./base_server.nix];

  gameserver.server = {
    enable = true;
    gameTitle = "Dragomon Hunters";
    serverName = "dsoServer";
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
}
