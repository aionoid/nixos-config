{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    beekeeper-studio
  ];
  containers.gfServer = {
    timeoutStartSec = "5min";
    privateNetwork = true;
    hostAddress = "10.233.1.1";
    localAddress = "10.233.1.2";
    autoStart = false;
    hostBridge = null;
    bindMounts = {
      "/root/gf_server/" = {
        hostPath = "/home/ovo/Documents/gf_server/";
        isReadOnly = false;
      };
    };
    config = {
      boot.isContainer = true;
      networking.hostName = lib.mkDefault "gfServer";
      networking.useDHCP = false;
      imports = [./gfserver.nix];
    };
  };
}
