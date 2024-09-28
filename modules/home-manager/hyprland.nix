{
  pkgs,
  inputs,
  ...
}: let
  # Elements
  hypr_border_size = 2;
  hypr_gaps_in = 5;
  hypr_gaps_out = 10;
  hypr_rounding = 10;
  #
  # # Colors
  # gradient_angle = "45deg";
  # active_border_col_1 = "0xFFB4A1DB";
  # active_border_col_2 = "0xFFD04E9D";
  # inactive_border_col_1 = "1e2030";
  # inactive_border_col_2 = "1e2030";
  # active_shadow_col = "0x66000000";
  inactive_shadow_col = "0x66000000";
  #group_border_col = "0xFFDB695B";
  #group_border_active_col = "0xFF4BC66D";
  #
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
          _ps=(waybar mako)
          for _prs in "$\{_ps[@]}"; do
            if [[ `pidof $\{_prs}` ]]; then
              killall -9 $\{_prs}
            fi
          done

    # Apply themes
    # ~/.config/hypr/scripts/gtkthemes &

    # Lauch notification daemon (mako)
    #~/.config/hypr/scripts/notifications &

    # Lauch statusbar (waybar)
    # ~/.config/hypr/scripts/statusbar &

    # Start network manager applet
    # $\{pkgs.gbar}/bin/gbar &
    ${pkgs.swww}/bin/swww-daemon &

    sleep 1

  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    #:INFO: hyprland and some plugins have version mismatch ?

    plugins = [
      #   inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
    #
    settings = {
      plugin = {
        borders-plus-plus = {
          count = 6;
        };
      };
      #   "plugin:borders-plus-plus" = {
      #     add_borders = 1; # 0 - 9
      #
      #     # you can add up to 9 borders
      #     "col.border_1" = "rgb(ffffff)";
      #     "col.border_2" = "rgb(2222ff)";
      #
      #     # -1 means "default" as in the one defined in general:border_size
      #     border_size_1 = 10;
      #     border_size_2 = -1;
      #
      #     # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
      #     natural_rounding = "yes";
      #   };
      #
      #-- Startup ----------------------------------------------------
      # exec-once = ["~/.config/hypr/scripts/startup"];
      exec-once = ''${startupScript}/bin/start'';

      #-- General ----------------------------------------------------
      general = {
        #	sensitivity = 1.0
        border_size = hypr_border_size;
        no_border_on_floating = false;
        gaps_in = hypr_gaps_in;
        gaps_out = hypr_gaps_out;
        # :FIX: stylix theme :mkDefault
        # "col.active_border" = "${active_border_col_1} ${active_border_col_2} ${gradient_angle}";
        # "col.inactive_border" = "${inactive_border_col_1} ${inactive_border_col_2} ${gradient_angle}";
        #cursor_inactive_timeout = 30
        layout = "dwindle";
        #no_cursor_warps = false
        #	apply_sens_to_raw = false
        #col.group_border = $group_border_col
        #col.group_border_active = $group_border_active_col
      };

      #-- Decoration -------------------------------------------------
      decoration = {
        rounding = hypr_rounding;
        #multisample_edges = true
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 10;
        shadow_render_power = 3;
        # :FIX: stylix theme :mkDefault
        # "col.shadow" = active_shadow_col;
        "col.shadow_inactive" = inactive_shadow_col;
        # shadow_offset = [0, 0]
        shadow_scale = 1.0;
        dim_inactive = false;
        dim_strength = 0.5;
        blur = {
          enabled = true;
          size = 16;
        };
        #screen_shader =
      };

      #-- Animations -------------------------------------------------
      animations = {
        enabled = true;
        animation = [
          "windowsIn,1,5,default,popin 0%"
          "windowsOut,1,5,default,popin"
          "windowsMove,1,5,default,slide"
          "fadeIn,1,8,default"
          "fadeOut,1,8,default"
          "fadeSwitch,1,8,default"
          "fadeShadow,1,8,default"
          "fadeDim,1,8,default"
          "border,1,10,default"
          "workspaces,1,5,default,slide"
        ];
      };

      #-- Input: Keyboard, Mouse, Touchpad ---------------------------
      input = {
        # kb_model =
        kb_layout = "us,ara";
        # kb_variant =
        kb_options = "grp:alt_shift_toggle";
        # kb_rules =
        # kb_file =
        numlock_by_default = false;
        repeat_rate = 25;
        repeat_delay = 600;
        sensitivity = 0.5;
        accel_profile = "adaptive";
        force_no_accel = false;
        left_handed = false;
        scroll_method = "2fg";
        scroll_button = 0;
        natural_scroll = false;
        follow_mouse = 1;
        float_switch_override_focus = 1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 1.0;
          middle_button_emulation = false;
          clickfinger_behavior = false;
          tap-to-click = true;
          drag_lock = false;
        };
        touchdevice = {
          transform = 0;
          #output =
        };
      };

      # #-- Workspace Gestures -----------------------------------------
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = false;
      };
      #
      # #-- Miscellaneous ----------------------------------------------
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = false;
        vfr = "on";
        vrr = 1;
        mouse_move_enables_dpms = false;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        disable_autoreload = false;
        enable_swallow = false;
        #swallow_regex =                ;
        focus_on_activate = true;
        #	no_direct_scanout = false      ;
      };

      # #-- Debug (Only for developers) --------------------------------
      debug = {
        overlay = false;
        damage_blink = false;
        disable_logs = false;
        disable_time = true;
        damage_tracking = 2;
      };
      #
      # #-- Blurring Layer Surfaces ------------------------------------
      layerrule = "blur";

      # #-- Output -----------------------------------------------------
      # monitor = ,preferred,auto,1
      # HOME setup
      monitor = [
        # :INFO: right monitor
        "HDMI-A-1,1600x900,1440x0,1.2"
        # :INFO: left monitor
        "DP-2,1440x900,0x0,1"
        # monitor = HDMI-A-1,1920x1080@60,1920x0,1
        ",preferred,auto,1"
      ];

      # #-- WORKSPACE ------------------------
      # workspace = [
      #   "1,monitor:DP-2,default:true"
      #   "2,monitor:DP-2,persistent:true"
      # ];

      # #-- Layout : Dwindle ------------------
      dwindle = {
        pseudotile = false;
        force_split = 0;
        preserve_split = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        no_gaps_when_only = false;
        use_active_for_splits = true;
      };
      # #-- Layout : Master --------------------------
      master = {
        special_scale_factor = 0.8;
        # new_is_master = true     ;
        new_on_top = false;
        no_gaps_when_only = false;
        orientation = "left";
        inherit_fullscreen = true;
      };

      # #-- Window Rules -----------------------------------------------
      windowrule = [
        "float, foot-float"
        "float, yad|nm-connection-editor|pavucontrolk"
        "float, xfce-polkit|kvantummanager|qt5ct"
        "float, feh|Viewnior|Gpicview|Gimp|MPlayer"
        "float, VirtualBox Manager|qemu|Qemu-system-x86_64"
        "float, title:File Operation Progress"
        "float, title:Confirm to replace files"

        "size 60% 64%, Viewnior"
        "center, Viewnior"

        "animation slide down,foot-full"
        "animation slide up,wlogout"
      ];

      bind = let
        notifycmd = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";
        term = "~/.config/hypr/scripts/terminal          ";
        volume = "~/.config/hypr/scripts/volume            ";
        backlight = "~/.config/hypr/scripts/brightness        ";
        screenshot = "~/.config/hypr/scripts/screenshot        ";
        lockscreen = "hyprlock                                 ";
        wlogout = "~/.config/hypr/scripts/wlogout           ";
        colorpicker = "~/.config/hypr/scripts/colorpicker       ";
        files = "thunar                                   ";
        editor = "geany                                    ";
        browser = "brave                                    ";
        rofi_launcher = "~/.config/hypr/scripts/rofi_launcher   ";
        rofi_runner = "~/.config/hypr/scripts/rofi_runner     ";
        rofi_music = "~/.config/hypr/scripts/rofi_music      ";
        rofi_network = "~/.config/hypr/scripts/rofi_network    ";
        rofi_powermenu = "~/.config/hypr/scripts/rofi_powermenu  ";
        rofi_screenshot = "~/.config/hypr/scripts/rofi_screenshot ";
        wofi_launcher = "wofi -I";
        wofi_screenshot = "~/.config/sway/scripts/screenshot.sh";

        wofi_menu = "~/.config/hypr/scripts/wofi_menu           ";
        wofi_powermenu = "~/.config/hypr/scripts/wofi_powermenu      ";
        background_swap = "~/.config/hypr/scripts/background          ";
        waybar_themes = "~/.config/hypr/waybar/scripts/change-theme.sh";
        cheatsheet = "foot --app-id='foot-float' --config=\"$HOME/.config/hypr/foot/foot.ini\" -t cheatsheet -e nvim ~/.config/hypr/cheatsheet.md";
      in [
        "SUPER, G, togglegroup"
        "SUPER, G, exec, ${notifycmd} 'Toggled Group Mode'"
        "SUPER, H, changegroupactive, b"
        "SUPER, L, changegroupactive, f"

        # # -- Terminal --
        "SUPER,       Return, exec, ${term}   "
        "SUPER_SHIFT, Return, exec, ${term} -f"
        "SUPER_ALT,   Return, exec, ${term} -s"
        "SUPER,       T,      exec, ${term} -F"
        #
        # # -- Apps --
        "SUPER, N, exec, ${files}        "
        "SUPER_SHIFT, E, exec, ${editor} "
        "SUPER_SHIFT, W, exec, ${browser}"
        #
        # # -- Rofi --
        # # bindr = SUPER, SUPER_L, exec, ${rofi_launcher}
        "SUPER, D,       exec, ${rofi_launcher}   "
        "SUPER, R,       exec, ${rofi_runner}     "
        "SUPER, M,       exec, ${rofi_music}      "
        "SUPER_SHIFT, N, exec, ${rofi_network}    "
        "SUPER, X,       exec, ${rofi_powermenu}  "
        "SUPER, A,       exec, ${rofi_screenshot} "
        #
        # # -- Wofi --
        #  "SUPER, SUPER_L, exec, ${wofi_menu      }"
        #  "SUPER, D,       exec, ${wofi_menu      }"
        #  "SUPER, X,       exec, ${wofi_powermenu }"
        #  "SUPER, A,       exec, ${wofi_screenshot}"
        #
        # # -- Misc --
        # "SUPER,    N, exec, nm-connection-editor  "
        # "SUPER,    X, exec, ${wlogout}              "
        "SUPER,    P, exec, ${colorpicker}"
        "CTRL_ALT, L, exec, ${lockscreen}"
        "SUPER_SHIFT, B, exec, ${background_swap}"
        "SUPER_SHIFT, T, exec, ${waybar_themes}"
        #
        # # -- Scratchpad --
        "SUPER_SHIFT, EQUAL, movetoworkspace,special"
        "SUPER, EQUAL, togglespecialworkspace,      "
        #
        # # -- CHEATSHEET --
        "SUPER_SHIFT, I, exec, ${cheatsheet}"
        #
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
        #
        # # -- Screenshots --
        ",      Print, exec, ${screenshot} --now  "
        "ALT,   Print, exec, ${screenshot} --in5  "
        "SHIFT, Print, exec, ${screenshot} --in10 "
        "CTRL,  Print, exec, ${screenshot} --win  "
        "SUPER, Print, exec, ${screenshot} --area "
        #
        # # -- Hyprland --
        # # bind = SUPER,       C,      killactive,
        "SUPER,       Q,      killactive,                         "
        "CTRL_ALT,    Delete, exit,                               "
        "SUPER,       F,      fullscreen, 0                       "
        "SUPER,       F,      exec, ${notifycmd} 'Fullscreen Mode'  "
        "SUPER,       S,      pseudo,                             "
        "SUPER,       S,      exec, ${notifycmd} 'Pseudo Mode'      "
        "SUPER,       Space,  togglefloating,                     "
        "SUPER,       Space,  centerwindow,                       "
        #
        # # Change Focus
        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"
        #
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
        # "SUPER, 7, split-workspace, 7 "
        # "SUPER, 8, split-workspace, 8 "
        # "SUPER, 9, split-workspace, 9 "
        # "SUPER, 0, split-workspace, 10"
        #
        # bind = SUPER, ampersand, workspace, 1
        # bind = SUPER, eacute, workspace, 2
        # bind = SUPER, quotedbl, workspace, 3
        # bind = SUPER, apostrophe, workspace, 4
        # bind = SUPER, parenleft, workspace, 5
        # bind = SUPER, minus, workspace, 6
        # bind = SUPER, egrave, workspace, 7
        # bind = SUPER, underscore, workspace, 8
        # bind = SUPER, ccedilla, workspace, 9
        # bind = SUPER, agrave, workspace, 10
        #
        # # Send to Workspaces
        "SUPER_SHIFT, 1, split-movetoworkspace, 1"
        "SUPER_SHIFT, 2, split-movetoworkspace, 2"
        "SUPER_SHIFT, 3, split-movetoworkspace, 3"
        "SUPER_SHIFT, 4, split-movetoworkspace, 4"
        "SUPER_SHIFT, 5, split-movetoworkspace, 5"
        "SUPER_SHIFT, 6, split-movetoworkspace, 6"
        # "SUPER_SHIFT, 7, split-movetoworkspace, 7"
        # "SUPER_SHIFT, 8, split-movetoworkspace, 8"
        #
        # ==> Send to MONITOR <== #
        "SUPER_SHIFT, l, split-changemonitor, next"
        "SUPER_SHIFT, h, split-changemonitor, prev"
        #
        # ==> Focus to MONITOR <== #
        "SUPER, l, movefocus,r"
        "SUPER, h, movefocus,l"
        "SUPER, k, movefocus,u"
        "SUPER, j, movefocus,d"

        # bind = SUPER_SHIFT, ampersand, movetoworkspace, 1
        # bind = SUPER_SHIFT, eacute, movetoworkspace, 2
        # bind = SUPER_SHIFT, quotedbl, movetoworkspace, 3
        # bind = SUPER_SHIFT, apostrophe, movetoworkspace, 4
        # bind = SUPER_SHIFT, parenleft, movetoworkspace, 5
        # bind = SUPER_SHIFT, minus, movetoworkspace, 6
        # bind = SUPER_SHIFT, egrave, movetoworkspace, 7
        # bind = SUPER_SHIFT, underscore, movetoworkspace, 8
        # bind = SUPER_SHIFT, ccedilla, movetoworkspace, 9
        # bind = SUPER_SHIFT, agrave, movetoworkspace, 10
        #
        # # Change Workspace Mode
        "SUPER_CTRL, F, workspaceopt, allfloat                    "
        "SUPER_CTRL, F, exec, $notifycmd 'Toggled All Float Mode' "
        "SUPER_CTRL, S, workspaceopt, allpseudo                   "
        "SUPER_CTRL, S, exec, $notifycmd 'Toggled All Pseudo Mode'"
        #
        # # Misc
        # # bind = "SUPER_SHIFT, O, toggleopaque                "
        "SUPER_SHIFT, P, pin,                          "
        "SUPER_SHIFT, S, swapnext                      "
        "SUPER_SHIFT, P, exec, $notifycmd 'Toggled Pin'"
      ];

      bindl = let
        lockscreen = "hyprlock";
      in [
        ",switch:Lid Switch, exec, echo 'Lid Switch'"
        ",switch:on:Lid Switch, exec, ${lockscreen}"
      ];
      #
      # #-- Mouse Buttons ----------------------------------------------
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
