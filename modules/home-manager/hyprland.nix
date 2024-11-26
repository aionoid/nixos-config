{...}: {
  imports = [
    ./hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    #:INFO: hyprland and some plugins have version mismatch ?

    settings = {
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
        focus_on_activate = true;
        #swallow_regex =                ;
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
      # monitor = [
      #   # :INFO: right monitor
      #   "HDMI-A-1,1600x900,1440x0,1.2"
      #   # :INFO: left monitor
      #   "DP-2,1440x900,0x0,1"
      #   # monitor = HDMI-A-1,1920x1080@60,1920x0,1
      #   ",preferred,auto,1"
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
