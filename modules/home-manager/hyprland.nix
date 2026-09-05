{pkgs, ...}: {
  imports = [
    ./hyprland
  ];
  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = ["hyprland" "gtk"];
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # #-- Miscellaneous ----------------------------------------------
      config.misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = false;
        vrr = 1;
        mouse_move_enables_dpms = false;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        disable_autoreload = false;
        enable_swallow = false;
        focus_on_activate = true;
        #swallow_regex =                ;
        #	no_direct_scanout = false      ;
      };

      # #-- Debug (Only for developers) --------------------------------
      # config.debug = {
      #   overlay = false;
      #   damage_blink = false;
      #   disable_logs = false;
      #   disable_time = true;
      #   damage_tracking = 2;
      # };

      # #-- Layout : Dwindle ------------------
      config.dwindle = {
        # pseudotile = false; #BUG: option removed ?
        force_split = 0;
        preserve_split = false;
        # NOTE: deprecated / no-op in Hyprland 0.56 (kept for reference)
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
      };
      # #-- Layout : Master --------------------------
      config.master = {
        # NOTE: deprecated / no-op in Hyprland 0.56 (kept for reference)
        special_scale_factor = 0.8;
        new_on_top = false;
        orientation = "left";
        # inherit_fullscreen = true; # REMOVED
      };

      # #-- Blurring Noctalia Layer Surfaces ---------------------------
      # Modern Lua API: hl.layer_rule({ match = { namespace = ... }, ... })
      # (replaces the legacy hyprlang `layerrule` string list, which the
      # 0.56 hl.config walker silently drops).
      # Noctalia docs "Blur" section: blur the bar/panels/dock/notifications,
      # and disable Hyprland's own layer animations for those surfaces so they
      # don't fight Noctalia's own animations.
      layer_rule = [
        {
          name = "noctalia";
          match.namespace =
            "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";
          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];

      # #-- Window Rules -----------------------------------------------
      # Modern Lua API: hl.window_rule({ match = { class/title = ... }, ... })
      # (replaces the legacy hyprlang `windowrule` string list).
      # NOTE: 0.56 matches with RE2 FullMatch (legacy used partial match), so
      # patterns are anchored with .* to preserve the old behaviour.
      window_rule = [
        {
          match.class = ".*foot-float.*";
          float = true;
        }
        {
          match.class = ".*kitty-float.*";
          float = true;
        }
        {
          match.class = ".*(yad|nm-connection-editor|pavucontrolk).*";
          float = true;
        }
        {
          match.class = ".*(xfce-polkit|kvantummanager|qt5ct).*";
          float = true;
        }
        {
          match.class = ".*(feh|Viewnior|Gpicview|Gimp|MPlayer).*";
          float = true;
        }
        {
          match.class = ".*(VirtualBox Manager|qemu|Qemu-system-x86_64).*";
          float = true;
        }
        {
          match.title = ".*File Operation Progress.*";
          float = true;
        }
        {
          match.title = ".*Confirm to replace files.*";
          float = true;
        }
        {
          match.class = ".*Waydroid.*";
          float = true;
        }
        {
          match.class = ".*com\\.jaoushingan\\.WaydroidHelper.*";
          float = true;
        }
        {
          match.class = ".*Waydroid.*";
          size = [
            414
            896
          ];
        }
        # "workspace 5, match:title .*Private.*"
        {
          match.class = ".*Waydroid.*";
          workspace = "4";
        }
        {
          match.class = ".*com\\.jaoushingan\\.WaydroidHelper.*";
          workspace = "4";
        }
        {
          match.class = ".*zen-beta.*";
          workspace = "2";
        }
        {
          match.class = ".*zen-beta.*";
          opacity = "1.0 override 0.85 override 0.95 override";
        }
        {
          match.class = ".*Viewnior.*";
          size = [
            "monitor_w * 0.60"
            "monitor_h * 0.64"
          ];
        }
        {
          match.class = ".*Viewnior.*";
          center = true;
        }
        {
          match.class = ".*foot-full.*";
          animation = "slide down";
        }
        {
          match.class = ".*kitty-full.*";
          animation = "slide down";
        }
        {
          match.class = ".*wlogout.*";
          animation = "slide up";
        }
      ];

      # #-- Output -----------------------------------------------------
      # monitor = ,preferred,auto,1
      # HOME setup
      # config.monitor = [
      #   # :INFO: right monitor
      #   "HDMI-A-1,1600x900,1440x0,1.2"
      #   # :INFO: left monitor
      #   "DP-2,1440x900,0x0,1"
      #   # monitor = HDMI-A-1,1920x1080@60,1920x0,1
      #   ",preferred,auto,1"
      # ];

      # bindl = let
      #   lockscreen = "hyprlock";
      # in [
      #   ",switch:Lid Switch, exec, echo 'Lid Switch'"
      #   ",switch:on:Lid Switch, exec, ${lockscreen}"
      # ];
      # #
      # # #-- Mouse Buttons ----------------------------------------------
      # bindm = [
      #   "SUPER, mouse:272, movewindow"
      #   "SUPER, mouse:273, resizewindow"
      # ];
    };
  };
}
