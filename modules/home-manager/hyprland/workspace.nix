{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      # #-- Workspace Gestures -----------------------------------------
      gestures = {
        # workspace_swipe = true;      # REMOVED
        # workspace_swipe_fingers = 3; # REMOVED
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = false;
      };
      # #-- WORKSPACE ------------------------
      # workspace = [
      #   "1,monitor:DP-2,default:true"
      #   "2,monitor:DP-2,persistent:true"
      # ];
      #

      bind = let
        notifycmd = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";
      in [
        #
        # # -- Scratchpad --
        "SUPER_SHIFT, EQUAL, movetoworkspace,special"
        "SUPER, EQUAL, togglespecialworkspace,      "
        #
        # # Change Focus
        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"
        #
        # ==> Focus to MONITOR <== #
        "SUPER, l, movefocus,r"
        "SUPER, h, movefocus,l"
        "SUPER, k, movefocus,u"
        "SUPER, j, movefocus,d"

        # # Move Active
        "SUPER_SHIFT, left,  movewindow, l"
        "SUPER_SHIFT, right, movewindow, r"
        "SUPER_SHIFT, up,    movewindow, u"
        "SUPER_SHIFT, down,  movewindow, d"
        #
        # # Resize Active
        "SUPER_CTRL, left,  resizeactive, -20 0"
        "SUPER_CTRL, right, resizeactive, 20 0 "
        "SUPER_CTRL, up,    resizeactive, 0 -20"
        "SUPER_CTRL, down,  resizeactive, 0 20 "
        #
        # # Move Active (Floating Only)
        "SUPER_ALT, left,  moveactive, -20 0"
        "SUPER_ALT, right, moveactive, 20 0 "
        "SUPER_ALT, up,    moveactive, 0 -20"
        "SUPER_ALT, down,  moveactive, 0 20 "
        #
        # # Switch between windows
        "SUPER,Tab,cyclenext,"
        "SUPER,Tab,bringactivetotop,"
        #
        # # Workspaces
        "SUPER, 1, split-workspace, 1 "
        "SUPER, 2, split-workspace, 2 "
        "SUPER, 3, split-workspace, 3 "
        "SUPER, 4, split-workspace, 4 "
        "SUPER, 5, split-workspace, 5 "
        "SUPER, 6, split-workspace, 6 "
        "SUPER, 7, split-workspace, 7 "
        "SUPER, 8, split-workspace, 8 "
        "SUPER, 9, split-workspace, 9 "
        "SUPER, 0, split-workspace, 10"
        #
        #
        # # Send to Workspaces
        "SUPER_SHIFT, 1, split-movetoworkspace, 1"
        "SUPER_SHIFT, 2, split-movetoworkspace, 2"
        "SUPER_SHIFT, 3, split-movetoworkspace, 3"
        "SUPER_SHIFT, 4, split-movetoworkspace, 4"
        "SUPER_SHIFT, 5, split-movetoworkspace, 5"
        "SUPER_SHIFT, 6, split-movetoworkspace, 6"
        "SUPER_SHIFT, 7, split-movetoworkspace, 7"
        "SUPER_SHIFT, 8, split-movetoworkspace, 8"
        #
        # ==> Send to MONITOR <== #
        "SUPER_SHIFT, l, split-changemonitor, next"
        "SUPER_SHIFT, h, split-changemonitor, prev"
        #
        # # Change Workspace Mode
        "SUPER_CTRL, F, workspaceopt, allfloat                    "
        "SUPER_CTRL, F, exec, ${notifycmd} 'Toggled All Float Mode' "

        "SUPER_CTRL, S, workspaceopt, allpseudo                   "
        "SUPER_CTRL, S, exec, ${notifycmd} 'Toggled All Pseudo Mode'"
        #
        # # Misc
        # # bind = "SUPER_SHIFT, O, toggleopaque                "
        "SUPER_SHIFT, P, pin,                          "
        "SUPER_SHIFT, S, swapnext                      "
        "SUPER_SHIFT, P, exec, ${notifycmd} 'Toggled Pin'"
        # # -- Function keys --
        # bind = ,XF86MonBrightnessUp,   exec, $backlight --inc
        # bind = ,XF86MonBrightnessDown, exec, $backlight --dec
        # bind = ,XF86AudioRaiseVolume,  exec, $volume --inc
        # bind = ,XF86AudioLowerVolume,  exec, $volume --dec
        # bind = ,XF86AudioMute,         exec, $volume --toggle
        # bind = ,XF86AudioMicMute,      exec, $volume --toggle-mic
        # bind = ,XF86AudioNext,         exec, playerctl next
        # bind = ,XF86AudioPrev,         exec, playerctl previous
        # bind = ,XF86AudioPlay,         exec, playerctl play
        # bind = ,XF86AudioStop,         exec, playerctl pause
      ];
    };
  };
}
