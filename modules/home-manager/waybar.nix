{pkgs, ...}: {
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.waybar.settings = {
    leftBar = {
      layer = "top"; # Waybar at top layer
      position = "top"; # Waybar position (top|bottom|left|right)
      # "width"= 1280; # Waybar width
      # Choose the order of the modules
      output = [
        # "DP-2"
        "HDMI-A-1"
      ];
      modules-left = ["hyprland/workspaces"];
      modules-center = ["mpd" "mpd#2" "mpd#3" "mpd#4"];
      modules-right = ["pulseaudio" "clock" "tray" "custom/lock" "custom/power"];

      #MODULES
      "hyprland/workspaces" = {
        "format" = "{name}: {icon}";
        "format-icons" = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "active" = "";
          "default" = "";
        };
        # "persistent-workspaces" = {
        #   "*" = 5; # 5 workspaces by default on every monitor
        #   "HDMI-A-1" = 3; # but only three on HDMI-A-1
        # };
      };
      # "hyprland/workspaces" = {
      #   "format" = "<sub>{icon}</sub>\n{windows}";
      #   "format-window-separator" = "\n";
      #   "window-rewrite-default" = "";
      #   "window-rewrite" = {
      #     "title<.*youtube.*>" = ""; # Windows whose titles contain "youtube"
      #     "class<firefox>" = ""; # Windows whose classes are "firefox"
      #     "class<firefox> title<.*github.*>" = ""; # Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
      #     "foot" = ""; # Windows that contain "foot" in either class or title. For optimization reasons, it will only match against a title if at least one other window explicitly matches against a title.
      #     "code" = "󰨞";
      #   };
      # };
      "mpd" = {
        "tooltip" = true;
        "tooltip-format" = "{artist} - {album} - {title} - Total Time : {totalTime:%M:%S}";
        "format" = " {elapsedTime:%M:%S}";
        "format-disconnected" = "⚠  Disconnected";
        "format-stopped" = " Not Playing";
        "on-click" = "mpc toggle";
        "state-icons" = {
          "playing" = "";
          "paused" = "";
        };
      };
      "mpd#2" = {
        "format" = "";
        "format-disconnected" = "";
        "format-paused" = "";
        "format-stopped" = "";
        # Commands to execute on events
        "on-click" = "mpc -q pause && mpc -q prev && mpc -q start";
      };
      "mpd#3" = {
        "interval" = 1;
        "format" = "{stateIcon}";
        "format-disconnected" = "";
        "format-paused" = "{stateIcon}";
        "format-stopped" = "";
        "state-icons" = {
          "paused" = "";
          "playing" = "";
        };
        # Commands to execute on events
        "on-click" = "mpc toggle";
      };
      "mpd#4" = {
        "format" = "";
        "format-disconnected" = "";
        "format-paused" = "";
        "format-stopped" = "";
        # Commands to execute on events
        "on-click" = "mpc -q pause && mpc -q next && mpc -q start";
      };
      "hypr/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "format" = "{icon}";
        # "format"= "< %g >";
        # "format_focused" = "< %g ● >";
        "format-icons" = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          "9" = "";
          "10" = "";
        };
      };
      "sway/workspaces" = {
        disable-scroll = true;
        sort-by-name = true;
        format = " {icon} ";
        format-icons = {
          default = "";
        };
      };
      tray = {
        icon-size = 21;
        spacing = 10;
      };
      "custom/music" = {
        "format" = "  {}";
        "escape" = true;
        "interval" = 5;
        "tooltip" = false;
        "exec" = "playerctl metadata --format='{{ title }}'";
        "on-click" = "playerctl play-pause";
        "max-length" = 50;
      };
      clock = {
        "timezone" = "Asia/Dubai";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = " {:%d/%m/%Y}";
        "format" = " {:%H:%M}";
      };
      backlight = {
        "device" = "intel_backlight";
        "format" = "{icon}";
        "format-icons" = ["" "" "" "" "" "" "" "" ""];
      };
      battery = {
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{icon}";
        "format-charging" = "";
        "format-plugged" = "";
        "format-alt" = "{icon}";
        "format-icons" = ["" "" "" "" "" "" "" "" "" "" "" ""];
      };
      pulseaudio = {
        # "scroll-step"= 1; // %, can be a float
        "format" = "{icon} {volume}%";
        "format-muted" = "";
        "format-icons" = {
          "default" = ["" "" " "];
        };
        "on-click" = "pavucontrol";
      };
      "custom/lock" = {
        "tooltip" = false;
        "on-click" = "sh -c '(sleep 0.5s; swaylock --grace 0)' & disown";
        "format" = "";
      };
      "custom/power" = {
        "tooltip" = false;
        "on-click" = "wlogout &";
        "format" = "襤";
      };
    };
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "DP-2"
        #"HDMI-A-1"
      ];
      modules-left = ["sway/workspaces" "sway/mode" "wlr/taskbar"];
      modules-center = ["sway/window" "custom/hello-from-waybar"];
      modules-right = ["mpd" "custom/mymodule#with-css-id" "temperature"];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };
      "custom/hello-from-waybar" = {
        format = "hello {}";
        max-length = 40;
        interval = "once";
        exec = pkgs.writeShellScript "hello-from-waybar" ''
          echo "from within waybar"
        '';
      };
    };
  };
  programs.waybar.style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;


    * {
      font-family: JetBrainsMono Nerd Font;
      font-size: 17px;
      min-height: 0;
    }

    #waybar {
      background: transparent;
      color: @text;
      margin: 5px 5px;
    }

    #workspaces {
      border-radius: 1rem;
      margin: 5px;
      background-color: @surface0;
      margin-left: 1rem;
    }

    #workspaces button {
      color: @lavender;
      border-radius: 1rem;
      padding: 0.4rem;
    }

    #workspaces button.active {
      color: @sky;
      border-radius: 1rem;
    }

    #workspaces button:hover {
      color: @sapphire;
      border-radius: 1rem;
    }

    #custom-music,
    #tray,
    #backlight,
    #clock,
    #battery,
    #pulseaudio,
    #custom-lock,
    #custom-power {
      background-color: @surface0;
      padding: 0.5rem 1rem;
      margin: 5px 0;
    }

    #clock {
      color: @blue;
      border-radius: 0px 1rem 1rem 0px;
      margin-right: 1rem;
    }

    #battery {
      color: @green;
    }

    #battery.charging {
      color: @green;
    }

    #battery.warning:not(.charging) {
      color: @red;
    }

    #backlight {
      color: @yellow;
    }

    #backlight, #battery {
        border-radius: 0;
    }

    #pulseaudio {
      color: @maroon;
      border-radius: 1rem 0px 0px 1rem;
      margin-left: 1rem;
    }

    #custom-music {
      color: @mauve;
      border-radius: 1rem;
    }

    #custom-lock {
        border-radius: 1rem 0px 0px 1rem;
        color: @lavender;
    }

    #custom-power {
        margin-right: 1rem;
        border-radius: 0px 1rem 1rem 0px;
        color: @red;
    }

    #tray {
      margin-right: 1rem;
      border-radius: 1rem;
    }
  '';
}
