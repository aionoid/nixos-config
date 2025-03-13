{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [
      pkgs.rofi-emoji-wayland
    ];
  };
  # rofi themes
  home.file = {
    ".config/rofi/launcher.rasi" = {
      text = builtins.readFile ./themes/launcher.rasi;
      executable = false;
    };
    ".config/rofi/fullscreen.rasi" = {
      text = builtins.readFile ./themes/fullscreen.rasi;
      executable = false;
    };
    ".config/rofi/applet.rasi" = {
      text = builtins.readFile ./themes/applet.rasi;
      executable = false;
    };
    ".config/rofi/shared/colors.rasi" = {
      # text = builtins.readFile ./shared/colors.rasi;
      text = with config.lib.stylix.colors;
      /*
      css
      */
        ''
          * {
            background:     #${base00}cc; /*#1E2127;*/
            background-alt: #${base01}cc; /*#282B31;*/
            foreground:     #${base05}cc; /*#FFFFFF;*/
            selected:       #${base0D}cc; /*#61AFEF;*/
            active:         #${base0B}cc; /*#98C379;*/
            urgent:         #${base08}cc; /*#E06C75;*/
           }
        '';
      executable = false;
    };
    ".config/rofi/shared/fonts.rasi" = {
      # text = builtins.readFile ./shared/fonts.rasi;
      text =
        /*
        css
        */
        ''

          * {
              font: "JetBrains Mono Nerd Font 10";
          }
        '';
      executable = false;
    };
  };
}
