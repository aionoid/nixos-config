{pkgs, ...}: {
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
}
