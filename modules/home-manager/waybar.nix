{config, ...}: let
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
      "active-only" = false;
      "disable-scroll" = true;
      "all-outputs" = false;
      "format" = "{icon}";
      "window-rewrite-default" = "";
      # "format_focused" = "< %g ● >";
      # "format-active" = {
      #   "1" = "󰎥";
      #   "2" = "󰎨";
      #   "3" = "󰎫";
      #   "4" = "󰎲";
      #   "5" = "󰎯";
      #   "6" = "󰎴";
      #   "7" = "󰎷";
      #   "8" = "󰎺";
      #   "9" = "󰎽";
      #   "10" = "󰿫";
      #   "11" = "󰎥";
      #   "12" = "󰎨";
      #   "13" = "󰎫";
      #   "14" = "󰎲";
      #   "15" = "󰎯";
      #   "16" = "󰎴";
      #   "17" = "󰎷";
      #   "18" = "󰎺";
      #   "19" = "󰎽";
      #   "20" = "󰿫";
      # };
      # "format-icons" = {
      #   "1" = "󰎦";
      #   "2" = "󰎩";
      #   "3" = "󰎬";
      #   "4" = "󰎮";
      #   "5" = "󰎰";
      #   "6" = "󰎵";
      #   "7" = "󰎸";
      #   "8" = "󰎻";
      #   "9" = "󰎾";
      #   "10" = "󰽾";
      #   "11" = "󰎦";
      #   "12" = "󰎩";
      #   "13" = "󰎬";
      #   "14" = "󰎮";
      #   "15" = "󰎰";
      #   "16" = "󰎵";
      #   "17" = "󰎸";
      #   "18" = "󰎻";
      #   "19" = "󰎾";
      #   "20" = "󰽾";
      #   "active" = "󰼎";
      #   "default" = "󰬻";
      #   "empty" = "󰼎";
      #   "persistent" = "󰬼";
      #   "special" = "󰬽";
      #   "urgent" = "󰬾";
      # };
      "format-icons" = {
        "1" = "󰎤";
        "2" = "󰎧";
        "3" = "󰎪";
        "4" = "󰎭";
        "5" = "󰎱";
        "6" = "󰎳";
        "7" = "󰎶";
        "8" = "󰎹";
        "9" = "󰎼";
        "10" = "󰽽";
        "11" = "󰎤";
        "12" = "󰎧";
        "13" = "󰎪";
        "14" = "󰎭";
        "15" = "󰎱";
        "16" = "󰎳";
        "17" = "󰎶";
        "18" = "󰎹";
        "19" = "󰎼";
        "20" = "󰽽";
        "active" = "󰼎";
        "default" = "󰬻";
        "empty" = "󰼎";
        "persistent" = "󰬼";
        "special" = "󰬽";
        "urgent" = "󰬾";
      };
    };
    "temperature" = {
      ## "thermal-zone"= 2;
      ## "hwmon-path"= "/sys/class/hwmon/hwmon2/temp1_input";
      ## "critical-threshold"= 80;
      ## "format-critical"= "{temperatureC}°C ";
      "format" = "{temperatureC}°C ";
    };
    "cpu" = with config.lib.stylix.scheme; {
      "interval" = 1;
      "format" = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15} 󰍛 ";
      "format-icons" = [
        "<span color='#${base0B}'>▁</span>" ## green   #69ff94
        "<span color='#${base0D}'>▂</span>" ## blue    #2aa9ff
        "<span color='#${base06}'>▃</span>" ## white   #f8f8f2
        "<span color='#${base06}'>▄</span>" ## white   #f8f8f2
        "<span color='#${base0A}'>▅</span>" ## yellow  #ffffa5
        "<span color='#${base0A}'>▆</span>" ## yellow  #ffffa5
        "<span color='#${base09}'>▇</span>" ## orange  #ff9977
        "<span color='#${base08}'>█</span>" ## red     #dd532e
      ];
    };
    "memory" = {
      "interval" = 30;
      "format" = "{used:0.1f}G/{total:0.1f}G  ";
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
    "network" = {
      #"interface" = "wlp2s0";
      "format" = "{ifname}";
      "format-wifi" = " {essid} ({signalStrength}%)  ";
      "format-ethernet" = " {ipaddr}/{cidr} 󰊗 ";
      "format-disconnected" = ""; #An empty format will hide the module.
      "tooltip-format" = "{ifname} via {gwaddr} 󰊗";
      "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
      "tooltip-format-ethernet" = "{ifname} ";
      "tooltip-format-disconnected" = "Disconnected";
      "max-length" = 50;
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
      "format-alt" = " {:%d/%m/%Y}";
      "format" = " {:%I:%M %p}";
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
    "hyprland/language" = {
      "format" = " {} 󰌌";
      "format-en" = "EN";
      "format-ar" = "AR";
      # "keyboard-name" = "at-translated-set-2-keyboard";
    };
    "keyboard-state" = {
      "numlock" = false;
      "capslock" = true;
      "format" = " {icon} ";
      "format-icons" = {
        "locked" = " ";
        "unlocked" = " ";
      };
    };
    "hyprland/window" = {
      "format" = "{class}";
      "separate-outputs" = true;
    };
    "hyprland/submap" = {
      "format" = "> {}";
      "max-length" = 8;
      "tooltip" = false;
    };
    "wlr/taskbar" = {
      "format" = "{icon}";
      "icon-size" = 14;
      #"icon-theme"= "Numix-Circle";
      "tooltip-format" = "{title}";
      "on-click" = "activate";
      "on-click-middle" = "close";
      "ignore-list" = [
        "Alacritty"
      ];
      "app_ids-mapping" = {
        "firefoxdeveloperedition" = "firefox-developer-edition";
      };
      "rewrite" = {
        "Firefox Web Browser" = "Firefox";
        "Foot Server" = "Terminal";
      };
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
        height = 20;
        # "width"= 1280; # Waybar width
        # Choose the order of the modules
        output = [
          # "DP-2"
          "HDMI-A-1"
        ];
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "hyprland/language" "keyboard-state" "pulseaudio" "clock"]; #"custom/lock" "custom/power"
      }
      // modules;

    mainBar =
      {
        layer = "top";
        position = "top";
        height = 20;
        output = [
          "DP-2"
          #"HDMI-A-1"
        ];
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "hyprland/language" "keyboard-state" "pulseaudio" "clock"];
      }
      // modules;

    bottomBar =
      {
        layer = "top";
        position = "bottom";
        height = 20;
        # output = [
        #   "DP-2"
        #   "HDMI-A-1"
        # ];
        modules-left = ["wlr/taskbar"];
        modules-center = ["mpd" "mpd#2" "mpd#3" "mpd#4" "cava"];
        modules-right = ["cpu" "memory" "network" "temperature"];
      }
      // modules;
  };

  programs.waybar.style = with config.lib.stylix.scheme; ''
            @define-color rosewater #${base06}; /*#f5e0dc;*/
            @define-color flamingo #${base0F};  /*#f2cdcd;*/
            @define-color pink #${base0F};      /*#f5c2e7;*/
            @define-color mauve #${base0E};     /*#cba6f7;*/
            @define-color red #${base08};       /*#f38ba8;*/
            @define-color maroon #${base08};    /*#eba0ac;*/
            @define-color peach #${base09};     /*#fab387;*/
            @define-color yellow #${base0A};    /*#f9e2af;*/
            @define-color green #${base0B};     /*#a6e3a1;*/
            @define-color teal #${base0C};      /*#94e2d5;*/
            @define-color sky #${base0C};       /*#89dceb;*/
            @define-color sapphire #${base0D};  /*#74c7ec;*/
            @define-color blue #${base0D};      /*#89b4fa;*/
            @define-color lavender #${base07};  /*#b4befe;*/
            @define-color text #${base05};      /*#cdd6f4;*/
            @define-color subtext1 #${base04};  /*#bac2de;*/
            @define-color subtext0 #${base04};  /*#a6adc8;*/
            @define-color overlay2 #${base04};  /*#9399b2;*/
            @define-color overlay1 #${base04};  /*#7f849c;*/
            @define-color overlay0 #${base04};  /*#6c7086;*/
            @define-color surface2 #${base04};  /*#585b70;*/
            @define-color surface1 #${base03};  /*#45475a;*/
            @define-color surface0 #${base02};  /*#313244;*/
            @define-color base #${base00};      /*#1e1e2e;*/
            @define-color mantle #${base01};    /*#181825;*/
            @define-color crust #${base01};     /*#11111b;*/


        * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 17px;
          min-height: 0;
        }

    window#waybar, tooltip {
          /* background-image :linear-gradient(to bottom, #${base01}ff 0%, #${base0F}00 100% ); */
        background-image: linear-gradient(to bottom, rgba(${base00-rgb-r},${base00-rgb-r},${base00-rgb-r},1),rgba(${base00-rgb-r},${base00-rgb-r},${base00-rgb-r},0));
        color: @base05;
    }
    window#waybar.bottom {
        background-image: linear-gradient(to top, rgba(${base00-rgb-r},${base00-rgb-r},${base00-rgb-r},1),rgba(${base00-rgb-r},${base00-rgb-r},${base00-rgb-r},0));
        color: @base05;
    }
        #waybar {
          background-image :linear-gradient(to bottom, #${base01} 0%, #${base0F} 100% ); /* transparent;*/
          color: @text;
          margin: 5px 5px;
        }

         #workspaces {
          /* border-radius: 1rem; */
          /* background-color: @surface0; */
          margin: 5px;
          margin-left: 1rem;
        }

        #workspaces button {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.4rem;
        }

        #workspaces button.empty {
          color: @gray;
          border-radius: 1rem;
        }

        #workspaces button.visible {
          color: @yellow;
          border-radius: 1rem;
        }

        #workspaces button.active {
          color: @sky;
          border-radius: 1rem;
        }

        #workspaces button.urgent{
          color: @red;
          border-radius: 1rem;
        }

        #workspaces button:hover {
          color: @sapphire;
          border-radius: 1rem;
        }

        #custom-music,
        #tray,
        #backlight,
        #cpu
        #memory
        #network
        #temperature
        #clock,
        #battery,
        #pulseaudio,
        #custom-lock,
        #custom-power {
          /* background-color: @surface0; */
          padding: 0.5rem 1rem;
          margin: 5px 0;
        }

        #clock {
          /* border-radius: 0px 1rem 1rem 0px; */
          /* color: @blue; */
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
          /* border-radius: 1rem 0px 0px 1rem; */
          /* color: @maroon; */
          margin-left: 1rem;
        }

        #custom-lock {
            /* border-radius: 1rem 0px 0px 1rem; */
            color: @lavender;
        }

        #custom-power {
            /* border-radius: 0px 1rem 1rem 0px; */
            margin-right: 1rem;
            color: @red;
        }
  '';
}
