{
  pkgs,
  config,
  ...
}: {
  programs.hyprlock = with config.lib.stylix.colors; let
    fontColor = "rgb(${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b})";
    outColor = fontColor;
    backColor = "rgb(${base01-rgb-r}, ${base01-rgb-g}, ${base01-rgb-b})";
    errorColor = "rgb(${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b})";
  in {
    enable = true;
    settings = {
      background = [
        {
          # monitor =
          # path = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/vnc-d.png"; # only png supported for now;
          path = "screenshot";
          color = "rgb(36, 39, 58)";
          # color = "rgb(${base0c-rgb-r}, ${base0c-rgb-g}, ${base0c-rgb-b})";
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
          # outer_color = " rgb(198, 160, 246)";
          # font_color = " rgb(198, 160, 246)";
          # inner_color = " rgb(36, 39, 58)";
          # fail_color = " rgb(237, 135, 150)"; # if authentication failed, changes outer_color and fail message color";
          outer_color = outColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          font_color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          inner_color = backColor; # "rgb(${base01-rgb-r}, ${base01-rgb-g}, ${base01-rgb-b})";
          fail_color = errorColor; # "rgb(${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b})";
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
          text = ''cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"'';
          # color = "rgb(198, 160, 246)";
          color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          font_size = "84";
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 96";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"'';
          # text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
          # color = "rgb(198, 160, 246)";
          color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          font_size = "84";
          font_family = "JetBrains Mono Nerd Font ";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b><span> $(date +"%S") </span></b>"'';
          # text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
          # color = "rgb(198, 160, 246)";
          color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          font_size = "44";
          font_family = "JetBrains Mono Nerd Font 10";
          position = "110, -20";
          halign = "center";
          valign = "center";
        }
        # # User label
        {
          #monitor =
          monitor = "";
          text = ''Hey <span text_transform="capitalize" size="larger">$USER</span>'';
          # color = " rgb(198, 160, 246)";
          color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          font_size = " 20";
          font_family = " JetBrains Mono Nerd Font 10";
          position = " 0, 170";
          halign = " center";
          valign = " center";
        }
        # # Keyboard Layout
        {
          #     monitor =
          monitor = "";
          text = "Current Layout : $LAYOUT";
          color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          # color = "rgb(198, 160, 246)";
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
          color = fontColor; # "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
          # color = "rgb(198, 160, 246)";
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
