{pkgs, ...}: {
  home.packages = with pkgs; [
    # hyprpanel
    networkmanagerapplet
    # swww
    libnotify
    xdg-user-dirs
  ];
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "noctalia-shell" # run noctalia with hyprland
      "swww-daemon"
      "nm-applet"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "scriptChangeWallpaper ~/Pictures/wallpaper"
      # "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    ];
  };
}
