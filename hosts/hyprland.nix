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
  # INFO: we can use sddm+theme
  # using regreet for now better than regreetd
  programs.regreet.enable = true;
  programs.regreet.settings = {
    GTK.application_prefer_dark_theme = true;
    # GTK.theme_name = "Gtk";
    # GTK.cursor_theme_name = "Bibata-Modern-Ice";
    # GTK.font_name = "JetBrainsMono Nerd Font Mono";
    appearance.greeting_msg = "HELLO BOSS";
    backgound.path = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/morphogenesis-d.svg";
  };

  # SDDM
  # services.displayManager.sddm = {
  #   wayland.enable = true;
  #   enable = true;
  #   autoNumlock = true;
  #   # settings.Theme.Current = "catppuccin-mocha";
  #   theme = "catppuccin-mocha";
  #   package = pkgs.kdePackages.sddm;
  # };
  # services.regreetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };

  home.systemPackages = with pkgs; [
    # (catppuccin-sddm.override
    #   {
    #     flavor = "mocha";
    #     background = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/morphogenesis-d.svg";
    #     loginBackground = true;
    #   })
    # hyprpaper
    # kitty
    nemo-with-extensions
    # TODO: enable from home-manager to add configuration
    rofi-wayland
    waybar
    swww
    # gnome-icon-theme

    #==> #### Yurihikari #### <== #
    # swaylock-effects
    hyprlock
    rofi-wayland
    # neofetch
    cava
    foot
    # hyprland ==> home-manager config
    # mpd ===> home-manager config
    mpc-cli
    # rose-pine-cursor
    hyprcursor
    # rose-pine-hyprcursor
    font-awesome
    # nerd-fonts
    hyprpicker
    # wireplumber
    nwg-launchers
    most
    pavucontrol
    pamixer
    # swayfx
    bluez
    bluez-tools
    gpu-screen-recorder
    btop
    networkmanager
    wl-clipboard
    # tools to get/generate color chema
    dart-sass
    matugen
    # brightnessctl
    # gnome-bluetooth
    # aylurs-gtk-shell
    blueberry
    # tools for screenshots
    slurp
    grim
    grimblast
  ];
}
