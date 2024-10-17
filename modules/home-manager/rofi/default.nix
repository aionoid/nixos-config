{pkgs, ...}: {
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
    ".config/rofi/shared/colors.rasi" = {
      text = builtins.readFile ./shared/colors.rasi;
      executable = false;
    };
    ".config/rofi/shared/fonts.rasi" = {
      text = builtins.readFile ./shared/fonts.rasi;
      executable = false;
    };
  };
}
