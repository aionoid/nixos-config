{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../global.nix
    # ../common/users/gabriel
    #
    # ../common/optional/peripherals.nix
    # ../common/optional/greetd.nix
    # ../common/optional/pipewire.nix
    # ../common/optional/quietboot.nix
    # ../common/optional/wireless.nix
    #
    # ../common/optional/starcitizen-fixes.nix
  ];

  networking = {
    #useDHCP = true;
    hostName = "work";
  };

  # set defaultUserShell for all users
  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.antiroot = {
    isNormalUser = true;
    description = "antiroot";
    extraGroups = ["networkmanager" "wheel"];
    useDefaultShell = true;
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ara";
    options = "terminate:ctrl_alt_bksp";
    variant = "";
  };
}
