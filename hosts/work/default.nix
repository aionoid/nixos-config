{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../global.nix
    ../gnome.nix
    # ../hyprland.nix
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
    # packages = with pkgs; [ ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ara";
    options = "grp:lalt_lshift_toggle";
    variant = "";
  };
}
