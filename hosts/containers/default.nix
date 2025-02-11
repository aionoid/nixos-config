{
  lib,
  pkgs,
  config,
  ...
}: {
  #FIXME: cant use 2 serverName fix on base_server
  imports = [
    # ./dsoserver.nix
    ./gfserver.nix
  ];
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "adminer" "${pkgs.php}/bin/php -S 'localhost:8000' -t ${pkgs.adminer}/ &
    xdg-open 'localhost:8000/adminer.php'")
  ];
  # containers.gfServer = {
  #   timeoutStartSec = "5min";
  #   privateNetwork = true;
  #   hostAddress = "10.233.1.1";
  #   localAddress = "10.233.1.2";
  #   autoStart = false;
  #   hostBridge = null;
  #   bindMounts = {
  #     "/root/gf_server/" = {
  #       hostPath = "/home/ovo/Documents/gf_server/";
  #       isReadOnly = false;
  #     };
  #   };
  #   config = {
  #     boot.isContainer = true;
  #     networking.hostName = lib.mkDefault "gfServer";
  #     networking.useDHCP = false;
  #     imports = [./gfserver.nix];
  #   };
  # };
  # containers.dsoServer = {
  #   timeoutStartSec = "5min";
  #   privateNetwork = true;
  #   hostAddress = "192.168.1.1";
  #   localAddress = "192.168.1.55";
  #   autoStart = false;
  #   hostBridge = null;
  #   bindMounts = {
  #     "/root/dso_server/" = {
  #       hostPath = "/home/ovo/Documents/dso_server/";
  #       isReadOnly = false;
  #     };
  #   };
  #   config = {
  #     boot.isContainer = true;
  #     networking.hostName = lib.mkDefault "dsoServer";
  #     networking.useDHCP = false;
  #     imports = [./dsoserver.nix];
  #   };
  # };
}
