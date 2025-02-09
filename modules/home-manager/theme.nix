{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../theme.nix
  ];

  #TODO: move to theme folder
  gtk = {
    enable = true;
    iconTheme = {
      # name = "Obsidian-Aqua";
      # package = pkgs.iconpack-obsidian;
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # qt = {
  #   enable = true;
  #   # platformTheme.name = "gtk3";
  #   # style.name = "gtk2";
  # };

  # home.packages = with pkgs; [
  #   themechanger
  #   # adwaita-qt
  #   # adwaita-qt6
  #   libsForQt5.qt5ct
  #   libsForQt5.qtstyleplugins
  #   libsForQt5.qtstyleplugin-kvantum
  #   qt6Packages.qt6ct
  #   qt6Packages.qt6gtk2
  #   qt6Packages.qtstyleplugin-kvantum
  #   # qgnomeplatform
  #   # qgnomeplatform-qt6
  #   # libsForQt5.breeze-qt5
  #   # libsForQt5.plasma-integration
  #   # lxqt.lxqt-config
  #   # lxqt.lxqt-qtplugin
  # ];

  # stylix.targets.waybar.enable = false;
  # stylix.targets.hyprpaper.enable = lib.mkForce false;
}
