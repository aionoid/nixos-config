{pkgs, ...}: {
  imports = [
    ../theme.nix
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugins
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    qt6Packages.qt6gtk2
    qt6Packages.qtstyleplugin-kvantum
  ];
}
