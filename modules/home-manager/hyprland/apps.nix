{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        notifycmd = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";
        term = "~/.config/hypr/scripts/terminal          ";
        screenshot = "~/.config/hypr/scripts/screenshot        ";
        lockscreen = "hyprlock                                 ";
        colorpicker = "~/.config/hypr/scripts/colorpicker       ";
        files = "nautilus";
        editor = "nvim";
        browser = "firefox";
        rofi_launcher = "~/.config/hypr/scripts/rofi_launcher   ";
        rofi_runner = "~/.config/hypr/scripts/rofi_runner     ";
        rofi_music = "~/.config/hypr/scripts/rofi_music      ";
        rofi_network = "~/.config/hypr/scripts/rofi_network    ";
        rofi_powermenu = "~/.config/hypr/scripts/rofi_powermenu  ";
        rofi_screenshot = "~/.config/hypr/scripts/rofi_screenshot ";
        background_swap = "~/.config/hypr/scripts/background          ";
        waybar_themes = "~/.config/hypr/waybar/scripts/change-theme.sh";
        cheatsheet = "foot --app-id='foot-float' --config=\"$HOME/.config/hypr/foot/foot.ini\" -t cheatsheet -e nvim ~/.config/hypr/cheatsheet.md";
        # volume = "~/.config/hypr/scripts/volume            ";
        # backlight = "~/.config/hypr/scripts/brightness        ";
        # wlogout = "~/.config/hypr/scripts/wlogout           ";
        # wofi_launcher = "wofi -I";
        # wofi_screenshot = "~/.config/sway/scripts/screenshot.sh";
        #
        # wofi_menu = "~/.config/hypr/scripts/wofi_menu           ";
        # wofi_powermenu = "~/.config/hypr/scripts/wofi_powermenu      ";
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
        # # -- CHEATSHEET --
        "SUPER_SHIFT, I, exec, ${cheatsheet}"
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
      ];
    };
  };
}
