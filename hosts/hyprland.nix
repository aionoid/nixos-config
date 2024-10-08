{
  inputs,
  pkgs,
  ...
}: {
  # nix.settings = {
  #   substituters = ["https://hyprland.cachix.org"];
  #   trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  # };

  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  # allow home-manager hyprlock to work
  security.pam.services.hyprlock = {};

  #TODO: clean for only apps used by hyprland
  environment.systemPackages = with pkgs; #host/Hyprland
  
    [
      nautilus
      gthumb
      loupe
      # nemo-with-extensions
      swww
      # gnome-icon-theme

      #==> #### Yurihikari #### <== #
      # swaylock-effects
      hyprlock
      rofi-wayland
      cava
      foot
      mpc-cli
      hyprcursor
      font-awesome
      hyprpicker
      nwg-launchers
      most
      pavucontrol
      pamixer
      bluez
      bluez-tools
      gpu-screen-recorder
      btop
      networkmanager
      networkmanagerapplet
      wl-clipboard
      # tools to get/generate color chema
      dart-sass
      blueberry
      # tools for screenshots
      slurp
      grim
      grimblast
      # TODO: for later case of use
      # matugen
      # brightnessctl
      # gnome-bluetooth
      # aylurs-gtk-shell
      # swayfx
    ];
}
