{
  config,
  pkgs,
  ...
}: let
  # ATTENTION: make sure this points to the correct location relative to this file
  # cpuid-fault-emulation = pkgs.callPackage ../../../pkgs/cpuid_fault_emulation {
  cpuid-fault-emulation = pkgs.callPackage ../../pkgs/cpuid-fault-emulation {
    kernel = config.boot.kernelPackages.kernel;
  };
in {
  # Disable UMIP
  boot.kernelParams = ["clearcpuid=umip"];

  # Hypervisor
  boot.extraModulePackages = [cpuid-fault-emulation];

  # Optional shell scripts to diasble and enable the hypervisor
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "enable-hypervisor" ''
      sudo modprobe -r kvm_amd kvm
      sudo modprobe cpuid_fault_emulation
    '')
    (pkgs.writeShellScriptBin "disable-hypervisor" ''
      sudo modprobe -r cpuid_fault_emulation
      sudo modprobe kvm_amd kvm
    '')
  ];
}
