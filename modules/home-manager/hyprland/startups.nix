{ pkgs, lib, ... }:
let
  # Hyprland 0.56+ runs the config in Lua. The old hyprlang `exec_cmd` list is
  # no longer the right autostart mechanism: home-manager renders it as
  # top-level `hl.exec_cmd(...)` calls, which fire while the config is still
  # being parsed — before the compositor is ready, so the apps die.
  #
  # The 0.56 way is a `hyprland.start` hook: it is emitted after the config
  # load and monitors are up (the same hook home-manager itself uses for its
  # `systemd` activation). `toLua` turns each Nix string into a quoted Lua
  # string literal, so ${store-path} interpolations keep working.
  toLua = lib.generators.toLua { };
  startupCommands = [
    # "noctalia" # run noctalia with hyprland (started via noctalia.nix now)
    # "swww-daemon"
    "nm-applet"
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    # "scriptChangeWallpaper ~/Pictures/wallpaper"
    # "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
    "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
  ];
in
{
  home.packages = with pkgs; [
    # hyprpanel
    networkmanagerapplet
    # swww
    libnotify
    xdg-user-dirs
  ];

  wayland.windowManager.hyprland.settings.on = {
    _args = [
      "hyprland.start"
      (lib.generators.mkLuaInline
        (
          "function()\n"
          + lib.concatMapStrings (cmd: "  hl.exec_cmd(${toLua cmd})\n") startupCommands
          + "end"
        )
      )
    ];
  };
}
