{pkgs, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          # monitor =
          path = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/vnc-d.png"; # only png supported for now;
          color = "rgb(36, 39, 58)";
          blur_size = 4;
          blur_passes = 3; # 0 disables blurring;
          noise = 0.0117;
          contrast = 1.000;
          brightness = 1.0000;
          vibrancy = 0.2100;
          vibrancy_darkness = 0.0;
        }
      ];
      input-field = [
        {
          #monitor =
          size = " 250, 50";
          outline_thickness = " 3";
          dots_size = " 0.2"; # Scale of input-field height, 0.2 - 0.8";
          dots_spacing = " 0.64"; # Scale of dots' absolute size, 0.0 - 1.0";
          dots_center = " true";
          outer_color = " rgb(198, 160, 246)";
          inner_color = " rgb(36, 39, 58)";
          font_color = " rgb(198, 160, 246)";
          fail_color = " rgb(237, 135, 150)"; # if authentication failed, changes outer_color and fail message color";
          fail_text = " <i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty";
          fail_transition = " 300"; # transition time in ms between normal outer_color and fail_color";
          fade_on_empty = " true";
          placeholder_text = " <i>Password...</i>"; # Text rendered in the input box when it's empty.";
          hide_input = " false";
          position = " 0, 150";
          halign = " center";
          valign = " bottom";
        }
      ];
      #
      # # Current time
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
          color = "rgb(198, 160, 246)";
          font_size = "64";
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 16";
          halign = "center";
          valign = "center";
        }
        # # User label
        {
          #monitor =
          monitor = "";
          text = ''Hey <span text_transform="capitalize" size="larger">$USER</span>'';
          color = " rgb(198, 160, 246)";
          font_size = " 20";
          font_family = " JetBrains Mono Nerd Font 10";
          position = " 0, 100";
          halign = " center";
          valign = " center";
        }
        # # Keyboard Layout
        {
          #     monitor =
          monitor = "";
          text = "Current Layout : $LAYOUT";
          color = "rgb(198, 160, 246)";
          font_size = "16";
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 70";
          halign = "center";
          valign = "bottom";
        }
        # # Type to unlock
        {
          # monitor =
          monitor = "";
          text = "Type to unlock!";
          color = "rgb(198, 160, 246)";
          font_size = "16";
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
