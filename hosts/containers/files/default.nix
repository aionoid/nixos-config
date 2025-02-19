{
  pkgs ? import <nixpkgs> {},
  db_password,
  db_members,
  db_account,
  server_address,
}: let
  configIni = import ./config.ini.nix;
  setupIni = import ./setup.ini.nix {
    inherit pkgs;
    inherit db_account;
    inherit db_members;
    inherit db_password;
    inherit server_address;
  };
in
  pkgs.stdenv.mkDerivation {
    name = "server-ini-installer";
    src = ./.;

    installPhase = ''
      # mkdir -p $out/root/server
      # cp ${setupIni} $out/root/server/setup.ini
        mkdir -p /root/server
        cp ${setupIni} /root/server/setup.ini
        cp ${configIni} /root/server/config.ini
    '';
  }
