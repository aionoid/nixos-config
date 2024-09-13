{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./nvidia.nix

    ../global.nix
  ];

  networking = {
    hostName = "home";
    #useDHCP = true;
  };

  # set defaultUserShell for all users
  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ovo = {
    isNormalUser = true;
    description = "ovo";
    extraGroups = ["networkmanager" "wheel"];
    useDefaultShell = true;
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ara";
    options = "terminate:ctrl_alt_bksp";
    variant = "";
  };
}
