{inputs, lib, ...}: let
  notify = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";
  # Pure-Lua split-monitor-workspaces package. The flake's `packages` output is only
  # the (now-deprecated) C++ build, so we require the Lua directly from the flake
  # source tree. `builtins.toString` on the flake yields its sourceInfo path.
  smwSrc = builtins.toString inputs.split-monitor-workspaces;
in {
  wayland.windowManager.hyprland = {
    settings = {
      # #-- Workspace Gestures -----------------------------------------
      config.gestures = {
        # Legacy workspace_swipe / workspace_swipe_fingers removed in new gesture backend
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = false;
      };
    };

    # Self-contained: the smw bootstrap (package.path + require + setup) lives here,
    # immediately before the binds that use it, so it does not depend on which
    # module's extraConfig home-manager renders first.
    extraConfig = ''
      -- #-- split-monitor-workspaces (pure Lua) --
      package.path = package.path .. ";${smwSrc}/?.lua"
      local smw = require("lua.split-monitor-workspaces")
      smw.setup({
        workspace_count = 10,     -- 10 split workspaces per monitor (SUPER+1 .. SUPER+0)
        enable_wrapping = true,   -- cycling past the edges wraps around
        keep_focused = true,      -- keep the focused workspace across reloads
        enable_persistent_workspaces = true,
        -- Explicit priorities so the right monitor (HDMI-A-1) owns workspaces 1-10
        -- and the left monitor (DP-2, 0x0) owns 11-20, regardless of detection order.
        monitor_priority = { "HDMI-A-1", "DP-2" },
      })

      -- #-- Workspace Gestures & Setup ---------------------------------

      -- Noctalia workspace-overview plugin (signature Noctalia binding on SUPER+TAB)
      hl.bind("SUPER + TAB", hl.dsp.exec_cmd("noctalia ipc call plugin:workspace-overview toggle"))

      -- # -- Scratchpad --
      hl.bind("SUPER + SHIFT + EQUAL", hl.dsp.window.move({ workspace = "special" }))
      hl.bind("SUPER + EQUAL", hl.dsp.workspace.toggle_special())

      -- # Change Focus
      hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }))
      hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }))
      hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }))
      hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }))

      -- ==> Focus to MONITOR <== #
      hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
      hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
      hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
      hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

      -- # Move Active
      hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
      hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
      hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
      hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))

      -- # Resize Active
      hl.bind("SUPER + CTRL + LEFT", hl.dsp.window.resize({ x = -20, y = 0 }))
      hl.bind("SUPER + CTRL + RIGHT", hl.dsp.window.resize({ x = 20, y = 0 }))
      hl.bind("SUPER + CTRL + UP", hl.dsp.window.resize({ x = 0, y = -20 }))
      hl.bind("SUPER + CTRL + DOWN", hl.dsp.window.resize({ x = 0, y = 20 }))

      -- # Move Active (Floating Only)
      hl.bind("SUPER + ALT + LEFT", hl.dsp.window.move({ x = -20, y = 0 }))
      hl.bind("SUPER + ALT + RIGHT", hl.dsp.window.move({ x = 20, y = 0 }))
      hl.bind("SUPER + ALT + UP", hl.dsp.window.move({ x = 0, y = -20 }))
      hl.bind("SUPER + ALT + DOWN", hl.dsp.window.move({ x = 0, y = 20 }))

      -- # Workspaces (split-monitor-workspaces: Nth workspace on the active monitor)
      -- SUPER + 1..9 -> workspaces 1..9, SUPER + 0 -> workspace 10
      for i = 1, 9 do
        hl.bind("SUPER + " .. tostring(i), smw.workspace(tostring(i)))
      end
      hl.bind("SUPER + 0", smw.workspace("10"))

      -- # Send active window to the Nth workspace on the active monitor (silent, no focus change)
      for i = 1, 9 do
        hl.bind("SUPER + SHIFT + " .. tostring(i), smw.move_to_workspace_silent(tostring(i)))
      end
      hl.bind("SUPER + SHIFT + 0", smw.move_to_workspace_silent("10"))

      -- # Cycle workspaces on the active monitor with the mouse wheel (SUPER held)
      hl.bind("SUPER + mouse_down", smw.cycle_workspaces("next"))
      hl.bind("SUPER + mouse_up", smw.cycle_workspaces("prev"))

      -- ==> Send active window to the next/previous MONITOR <== #
      hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ monitor = "+1" }))
      hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ monitor = "-1" }))

      -- # Change Workspace Mode
      -- # hl.bind("SUPER + CTRL + F", hl.dsp.workspace.opt({ option = "allfloat" }))
      -- # hl.bind("SUPER + CTRL + F", hl.dsp.exec_cmd("${notify} 'Toggled All Float Mode'"))
      -- #
      -- # hl.bind("SUPER + CTRL + S", hl.dsp.workspace.opt({ option = "allpseudo" }))
      -- # hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("${notify} 'Toggled All Pseudo Mode'"))

      -- # Misc
      hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())
      hl.bind("SUPER + SHIFT + S", hl.dsp.window.swap({ next = true }))
    '';
  };
}
