{pkgs, ...}: {
  home.packages = with pkgs; [
    # hyprpanel
    networkmanagerapplet
    swww
    libnotify
    xdg-user-dirs
  ];
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww-daemon"
      "nm-applet"
      "scriptChangeWallpaper ~/Pictures/wallpaper"
    ];
  };
}
