{pkgs, ...}: {
  imports = [
    ../theme.nix
  ];
  environment.sessionVariables = {
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    # QT_STYLE_OVERRIDE = "qt5ct";
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    # style = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    # kvantum
    # qgnomeplatform
    # qgnomeplatform-qt6
    # libsForQt5.plasma-integration
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugins
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    qt6Packages.qt6gtk2
    qt6Packages.qtstyleplugin-kvantum
    # lxqt.lxqt-config
    # lxqt.lxqt-qtplugin

    # adwaita-qt
    # adwaita-qt6
    # libsForQt5.breeze-qt5
    # qt6Packages.qt6gtk2
  ];
  # stylix.targets.gnome.enable = false;
}
