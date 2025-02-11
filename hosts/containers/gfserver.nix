{...}: {
  imports = [./base_server.nix];

  gameserver.server = {
    enable = true;
    gameTitle = "Grand Fantasia";
    serverName = "gfServer";
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
}
