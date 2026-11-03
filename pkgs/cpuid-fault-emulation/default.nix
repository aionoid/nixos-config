{
  stdenv,
  kernel,
  kmodigest,
}:
stdenv.mkDerivation {
  pname = "cpuid_fault_emulation";
  version = "0.1";

  src = ./source;

  nativeBuildInputs = [
    kernel.moduleBuildDependencies
    kmodigest
  ];
  hardeningDisable = [
    "pic"
    "format"
  ];

  # Patch the hardcoded host paths to point into the Nix store
  postPatch = ''
    substituteInPlace Makefile \
      --replace '/lib/modules/$(KERNEL)/build' '${kernel.dev}/lib/modules/${kernel.modDirVersion}/build' \
      --replace '$(shell uname -r)' '${kernel.modDirVersion}'
  '';

  installPhase = ''
    install -D cpuid_fault_emulation.ko \
      $out/lib/modules/${kernel.modDirVersion}/extra/cpuid_fault_emulation.ko
    # xanmod-signed nixpkgs expect every external module to carry a
    # kmodigest certificate so the merged modules tree can fold it into
    # modules.cer (pkgs/os-specific/linux/kmod/aggregator.nix).
    ${kmodigest}/bin/kmodigest $out/lib/modules/${kernel.modDirVersion}/extra/cpuid_fault_emulation.ko
  '';

  meta.platforms = ["x86_64-linux"];
}
