{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      #-- Input: Keyboard, Mouse, Touchpad ---------------------------
      input = {
        # kb_model =
        # kb_rules =
        # kb_file =
        # kb_variant =
        kb_layout = "us,ara";
        kb_options = "grp:alt_shift_toggle";
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
    };
  };
}
