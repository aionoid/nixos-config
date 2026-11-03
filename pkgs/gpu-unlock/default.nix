# gpu_unlock kernel module (https://github.com/Zagitta/gpu-unlock)
#
# Unlocks CMP-locked GA102/GA103/GA104/GA106 cards before the NVIDIA driver
# binds the card. Must be loaded before nvidia (see modules/nixos/gpu-unlock.nix).
{
  lib,
  stdenv,
  kernel,
  src,
  kmodigest,
}:
stdenv.mkDerivation rec {
  pname = "gpu-unlock";
  version = "2.0.0";

  inherit src;

  nativeBuildInputs = [
    kernel.moduleBuildDependencies
    kmodigest
  ];
  hardeningDisable = [
    "pic"
    "format"
  ];

  # The repo's kernel/gpu_unlock/Makefile drives kbuild:
  #   $(MAKE) -C "$(KDIR)" M="$(CURDIR)" modules
  # Build against the kernel dev output (full source + build tree).
  buildPhase = ''
    runHook preBuild
    make -C kernel/gpu_unlock \
      KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build
    runHook postBuild
  '';

  installPhase = ''
    install -D kernel/gpu_unlock/gpu_unlock.ko \
      $out/lib/modules/${kernel.modDirVersion}/extra/gpu_unlock.ko
    # xanmod-signed nixpkgs expect every external module to carry a
    # kmodigest certificate so the merged modules tree can fold it into
    # modules.cer (pkgs/os-specific/linux/kmod/aggregator.nix).
    ${kmodigest}/bin/kmodigest $out/lib/modules/${kernel.modDirVersion}/extra/gpu_unlock.ko
  '';

  meta = {
    description = "Kernel module that unlocks CMP-locked GA102/GA103/GA104/GA106 cards before the NVIDIA driver binds";
    homepage = "https://github.com/Zagitta/gpu-unlock";
    license = lib.licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
  };
}
