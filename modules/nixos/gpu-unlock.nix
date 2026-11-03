{
  inputs,
  config,
  pkgs,
  ...
}: let
  # ATTENTION: make sure this points to the correct location relative to this file
  gpu-unlock = pkgs.callPackage ../../pkgs/gpu-unlock {
    kernel = config.boot.kernelPackages.kernel;
    src = inputs.gpu-unlock;
    kmodigest = pkgs.kmodigest;
  };
  gpu-unlock-firmware = pkgs.callPackage ../../pkgs/gpu-unlock-firmware {
    src = inputs.gpu-unlock;
  };
in {
  # The module and its firmware (gpu-unlock/610.43.03/*.bin)
  boot.extraModulePackages = [ gpu-unlock ];
  hardware.firmware = [ gpu-unlock-firmware ];

  # Load in the initrd, before nvidia can bind a card. The modules closure
  # script pulls the MODULE_FIRMWARE files out of hardware.firmware into the
  # initrd automatically.
  boot.initrd.kernelModules.gpu_unlock = true;

  # Also load on the main system. Order within the set is irrelevant
  # (it is alphabetical): nvidia is not in the set, it is auto-loaded by
  # udev later, and systemd-modules-load runs before udev is started.
  boot.kernelModules.gpu_unlock = true;

  # The module is a no-op without this kernel parameter
  boot.kernelParams = [ "gpu_unlock.targets=all" ];
}
