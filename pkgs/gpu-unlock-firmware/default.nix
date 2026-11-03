# Firmware assets for the gpu_unlock kernel module
# (https://github.com/Zagitta/gpu-unlock, 2.0)
#
# Generates the 16 firmware blobs from the pinned NVIDIA 610.43.03 inputs,
# exactly like the repo's makepkg `build()` target:
#   1. extract_gsp.py: pull gsp_ga10x.bin / gsp_tu10x.bin out of the
#      NVIDIA driver installer and the license
#   2. extract_boot_assets.py: build the booter/boot/desc assets from the
#      610 generated sources
#
# All inputs are pinned (fetchurl sha256 values match
# packaging/arch/PKGBUILD sha256sums).
{
  lib,
  stdenvNoCC,
  fetchurl,
  python3,
  xz,
  zstd,
  src,
}:
stdenvNoCC.mkDerivation rec {
  pname = "gpu-unlock-firmware";
  version = "2.0.0";

  inherit src;

  nativeBuildInputs = [
    python3
    zstd
    xz
  ];

  # Pinned NVIDIA inputs (see packaging/arch/PKGBUILD)
  nvSource = fetchurl {
    url = "https://download.nvidia.com/XFree86/NVIDIA-kernel-module-source/NVIDIA-kernel-module-source-610.43.03.tar.xz";
    sha256 = "7e118923c7a23edc36114d63273a46e3e04e9af98695a42203e7ac2dfe9fc1dc";
  };
  nvInstaller = fetchurl {
    url = "https://download.nvidia.com/XFree86/Linux-x86_64/610.43.03/NVIDIA-Linux-x86_64-610.43.03-no-compat32.run";
    sha256 = "e084451db730a6df29d3d74f655749c4d236e3c945f7d94b5205e84318fe2f90";
  };

  buildPhase = ''
    runHook preBuild
    mkdir -p assets src
    tar -xf ${nvSource} -C src
    ${python3}/bin/python3 firmware/extract_gsp.py ${nvInstaller} assets
    ${python3}/bin/python3 firmware/extract_boot_assets.py src/NVIDIA-kernel-module-source-610.43.03 assets
    runHook postBuild
  '';

  # Paths must match the GU_FW_* MODULE_FIRMWARE() strings in
  # kernel/gpu_unlock/recipes.h (all 16 are declared in firmware_610.c).
  installPhase = ''
    install -Dm644 -t $out/lib/firmware/gpu-unlock/610.43.03 \
      assets/booter_load_ga100.bin \
      assets/booter_load_ga102.bin \
      assets/booter_load_ad102.bin \
      assets/booter_load_tu102.bin \
      assets/gsp_boot_ga100.bin \
      assets/gsp_boot_desc_ga100.bin \
      assets/gsp_boot_ga102.bin \
      assets/gsp_boot_desc_ga102.bin \
      assets/gsp_boot_ad102.bin \
      assets/gsp_boot_desc_ad102.bin \
      assets/gsp_boot_tu102.bin \
      assets/gsp_boot_desc_tu102.bin \
      assets/falcon_loader.bin \
      assets/gsp_ga10x.bin \
      assets/gsp_tu10x.bin \
      assets/sec2_bl_tu102.bin
  '';

  meta = {
    description = "Firmware assets for the gpu_unlock kernel module (610.43.03, v2.0 pipeline)";
    homepage = "https://github.com/Zagitta/gpu-unlock";
    license = lib.licenses.unfreeRedistributable;
    platforms = [ "x86_64-linux" ];
  };
}
