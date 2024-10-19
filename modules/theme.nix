{
  config,
  pkgs,
  ...
} @ inputs: {
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.image = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/morphogenesis-d.svg";
  # stylix.image = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/vnc-d.png";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

  stylix.opacity = {
    terminal = 0.9;
    popups = 0.9;
    desktop = 0.0;
    applications = 0.9;
  };

  # stylix.targets.waybar.enable = false;

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
  };

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      # package = pkgs.nerdfonts.override {fonts = ["Hermit"];};
      # name = "Hermit Nerd Font Mono";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      name = "JetBrainsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.twitter-color-emoji;
      name = "Twitter Color Emoji";
    };
  };
}
