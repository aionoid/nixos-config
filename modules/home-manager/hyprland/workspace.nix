{lib, ...}: let
  lua = lib.generators.mkLuaInline;
  notify = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";

  # Helper shortcuts for mapping your custom workspace / split dispatchers cleanly in Lua
  dsp = {
    exec = cmd: "hl.dsp.exec_cmd(\"${cmd}\")";
    splitWs = ws: "hl.dsp.exec_cmd(\"hyprsome workspace ${ws}\")"; # Adjust to your split manager command if different
    splitMovWs = ws: "hl.dsp.exec_cmd(\"hyprsome move ${ws}\")";
    splitMon = dir: "hl.dsp.exec_cmd(\"hyprsome monitor ${dir}\")";
  };
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

    # The new Lua-structured bind format via Home Manager generator
    extraConfig = ''
      -- #-- Workspace Gestures & Setup ---------------------------------

      -- Noctalia workspace-overview plugin
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

      -- # Switch between windows (Lambda block)
      hl.bind("SUPER + TAB", function()
          hl.dispatch(hl.dsp.window.cycle_next())
          hl.dispatch(hl.dsp.window.bring_to_top())
      end)

      -- # Workspaces (Split plugin mapping)
      hl.bind("SUPER + 1", hl.dsp.exec_cmd("hyprsome workspace 1"))
      hl.bind("SUPER + 2", hl.dsp.exec_cmd("hyprsome workspace 2"))
      hl.bind("SUPER + 3", hl.dsp.exec_cmd("hyprsome workspace 3"))
      hl.bind("SUPER + 4", hl.dsp.exec_cmd("hyprsome workspace 4"))
      hl.bind("SUPER + 5", hl.dsp.exec_cmd("hyprsome workspace 5"))
      hl.bind("SUPER + 6", hl.dsp.exec_cmd("hyprsome workspace 6"))
      hl.bind("SUPER + 7", hl.dsp.exec_cmd("hyprsome workspace 7"))
      hl.bind("SUPER + 8", hl.dsp.exec_cmd("hyprsome workspace 8"))
      hl.bind("SUPER + 9", hl.dsp.exec_cmd("hyprsome workspace 9"))
      hl.bind("SUPER + 0", hl.dsp.exec_cmd("hyprsome workspace 10"))

      -- # Send to Workspaces
      hl.bind("SUPER + SHIFT + 1", hl.dsp.exec_cmd("hyprsome move 1"))
      hl.bind("SUPER + SHIFT + 2", hl.dsp.exec_cmd("hyprsome move 2"))
      hl.bind("SUPER + SHIFT + 3", hl.dsp.exec_cmd("hyprsome move 3"))
      hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("hyprsome move 4"))
      hl.bind("SUPER + SHIFT + 5", hl.dsp.exec_cmd("hyprsome move 5"))
      hl.bind("SUPER + SHIFT + 6", hl.dsp.exec_cmd("hyprsome move 6"))
      hl.bind("SUPER + SHIFT + 7", hl.dsp.exec_cmd("hyprsome move 7"))
      hl.bind("SUPER + SHIFT + 8", hl.dsp.exec_cmd("hyprsome move 8"))

      -- ==> Send to MONITOR <== #
      hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprsome monitor next"))
      hl.bind("SUPER + SHIFT + H", hl.dsp.exec_cmd("hyprsome monitor prev"))

      -- # Change Workspace Mode
      -- # hl.bind("SUPER + CTRL + F", hl.dsp.workspace.opt({ option = "allfloat" }))
      -- # hl.bind("SUPER + CTRL + F", hl.dsp.exec_cmd("${notify} 'Toggled All Float Mode'"))
      -- #
      -- # hl.bind("SUPER + CTRL + S", hl.dsp.workspace.opt({ option = "allpseudo" }))
      -- # hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("${notify} 'Toggled All Pseudo Mode'"))

      -- # Misc
      hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())
      hl.bind("SUPER + SHIFT + S", hl.dsp.window.swap({ next = true }))
      hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("${notify} 'Toggled Pin'"))
    '';
  };
}
