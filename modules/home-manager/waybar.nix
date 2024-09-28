{pkgs, ...}: let
  modules = {
    #MODULES
    cava = {
      #        "cava_config"= "$XDG_CONFIG_HOME/cava/config";
      "framerate" = 30;
      "autosens" = 1;
      "sensitivity" = 100;
      "bars" = 14;
      "lower_cutoff_freq" = 50;
      "higher_cutoff_freq" = 10000;
      "method" = "pulse";
      "source" = "auto";
      "stereo" = true;
      "reverse" = false;
      "bar_delimiter" = 0;
      "monstercat" = false;
      "waves" = false;
      "noise_reduction" = 0.77;
      "input_delay" = 2;
      "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      "actions" = {
        "on-click-right" = "mode";
      };
    };
    "hyprland/workspaces" = {
      "format" = "{name}";
      # "format" = "{name}: {icon}";
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
      "all-outputs" = false;
      "format" = "{icon}";
      # "format"= "< %g >";
      "format_focused" = "< %g ● >";
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
      "timezone" = "Africa/Algiers";
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      "format-alt" = " {:%d/%m/%Y}";
      "format" = " {:%H:%M}";
    };
    backlight = {
      "device" = "intel_backlight";
      "format" = "{icon}";
      "format-icons" = ["" "" "" "" "" "" "" "" ""];
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
      "format" = "⏻";
    };
  };
in {
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.waybar.settings = {
    leftBar =
      {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        # "width"= 1280; # Waybar width
        # Choose the order of the modules
        output = [
          # "DP-2"
          "HDMI-A-1"
        ];
        modules-left = ["hyprland/workspaces"];
        modules-center = ["mpd" "mpd#2" "mpd#3" "mpd#4" "cava"];
        modules-right = ["pulseaudio" "clock" "tray" "custom/lock" "custom/power"];
      }
      // modules;

    mainBar =
      {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-2"
          #"HDMI-A-1"
        ];
        modules-left = ["hyprland/workspaces" "hyprland/mode" "wlr/taskbar"];
        modules-center = ["hyprland/window"];
        modules-right = ["cpu" "memory" "network" "clock" "temperature"];

        # "hyprland/workspaces" = {
        #   disable-scroll = true;
        #   all-outputs = false;
        # };
        # "custom/hello-from-waybar" = {
        #   format = "hello {}";
        #   max-length = 40;
        #   interval = "once";
        #   exec = pkgs.writeShellScript "hello-from-waybar" ''
        #     echo "from within waybar"
        #   '';
        # };
      }
      // modules;
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
