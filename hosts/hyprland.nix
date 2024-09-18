{
  inputs,
  pkgs,
  ...
}: {
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland = {
    enable = true;
    #FIXME: using hyprland repo package break on mason.build
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
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
  # services.regreetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };

  environment.systemPackages = with pkgs; [
    # hyprpaper
    # kitty
    rofi-wayland
    waybar
    swww
    gnome-icon-theme
  ];
}
