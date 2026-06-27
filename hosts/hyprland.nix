{
  inputs,
  pkgs,
  ...
}: {
  #------------------------------
  security.rtkit.enable = true;
  services.gvfs.enable = true; # Mounts the /run/user/1000/gvfsd directory

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  # allow home-manager hyprlock to work
  security.pam.services.hyprlock = {};

  environment.systemPackages = with pkgs; #host/Hyprland
  
    [
      # nautilus
      nemo-with-extensions
      gthumb
      loupe
      evince
      file-roller
      mpc # mpc-cli has been renamed to mpc
      font-awesome
      hyprpicker
      hyprcursor
      hyprprop
      nwg-launchers
      most
      pavucontrol
      pamixer
      bluez
      bluez-tools
      gpu-screen-recorder
      wl-clipboard
      # tools to get/generate color chema
      dart-sass
      # blueberry
      # tools for screenshots
      slurp
      grim
      grimblast
    ];
}
