{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f096eaa0-2ea3-43cc-ad1f-1ee631d14dda";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3419-09B2";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/mnt/DISK01" = {
    device = "/dev/disk/by-uuid/4482FC6082FC583E";
    fsType = "ntfs3";
    options = ["fmask=0000" "dmask=0000"];
  };

  fileSystems."/mnt/DISK02" = {
    device = "/dev/disk/by-uuid/0DD5BB1D58CC498D";
    fsType = "ntfs3";
    options = ["fmask=0000" "dmask=0000"];
  };

  # fileSystems."/mnt/DISK03" = {
  #   device = "/dev/disk/by-uuid/10039AFF0DD845A8";
  #   fsType = "ntfs3";
  #   options = ["fmask=0000" "dmask=0000"];
  # };

  fileSystems."/mnt/FAST" = {
    device = "/dev/disk/by-uuid/AC02035102031FC6";
    fsType = "ntfs3";
    options = ["fmask=0000" "dmask=0000"];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;
  # Bluetooth
  hardware.bluetooth.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
