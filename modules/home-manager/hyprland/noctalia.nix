# Noctalia (v5) integration for Hyprland.
#
# Implements the Hyprland-side settings recommended by the Noctalia docs
# (https://docs.noctalia.dev/noctalia/compositor-settings/hyprland/):
#   * Autostart Noctalia on compositor start (Lua hook, not systemd).
#   * IPC keybinds driving the Noctalia panels / window-switcher / media OSD.
#   * A window rule so the Noctalia settings window floats at a fixed size.
#
# The "Persistent Workspaces" section is intentionally skipped (we rely on the
# split-monitor-workspaces Lua package instead). The "Compositor Settings"
# section (gaps/rounding/shadow/blur) already lives in general.nix, and the
# "Blur" layer rule lives in hyprland.nix.
{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      # Noctalia settings window: float it and pin a fixed size so it behaves
      # like a dialog regardless of layout. Class confirmed live as
      # "dev.noctalia.Noctalia" (title "Noctalia Settings").
      window_rule = [
        {
          match.class = "dev.noctalia.Noctalia";
          float = true;
          size = [ 1080 920 ];
        }
      ];
    };

    # Self-contained: the autostart hook and every bind live in this one
    # extraConfig, so it does not depend on which module home-manager renders
    # first (extraConfig chunks are concatenated in reverse import order).
    extraConfig = ''
      -- #-- Noctalia (v5) ---------------------------------------------
      -- Autostart Noctalia when the compositor starts (docs: "Autostart
      -- Noctalia"). We use the Lua hook instead of the systemd user service so
      -- the instance is tied to this compositor session (see
      -- quickshell_noctalia.nix: systemd.enable = false).
      hl.on("hyprland.start", function()
        hl.exec_cmd("noctalia")
      end)

      -- #-- Noctalia IPC keybinds --------------------------------------
      -- `noctalia msg <cmd>` talks to the running Noctalia instance.
      local ipc = "noctalia msg "
      hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
      hl.bind("SUPER + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
      hl.bind("SUPER + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
      hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

      -- Media keys -> Noctalia OSD
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))
    '';
  };
}
