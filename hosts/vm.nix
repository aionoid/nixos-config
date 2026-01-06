{pkgs, ...}: {
  # Set up virtualisation
  virtualisation.libvirtd = {
    enable = true;

    # Enable TPM emulation (for Windows 11)
    qemu = {
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [virtiofsd];
      # ovmf.packages = [pkgs.OVMFFull.fd];
    };
  };

  # Enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;

  # Allow VM management
  users.groups.libvirtd.members = ["ovo" "antiroot"];
  users.groups.kvm.members = ["ovo" "antiroot"];

  programs.virt-manager.enable = true;

  # When running NixOS as a guest
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; # enable copy and paste between host and guest

  # Enable VM networking and file sharing
  environment.systemPackages = with pkgs; [
    # ... your other packages ...
    gnome-boxes # VM management
    dnsmasq # VM networking
    phodav # (optional) Share files with guest VMs
  ];
}
