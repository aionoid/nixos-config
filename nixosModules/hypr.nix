{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # setup this as a  module
  options = {
    ovo.hyprland.enable = lib.mkEnableOption "enables Hyprland WM";
  };

  config = lib.mkIf config.ovo.hyprland.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    #programs.hyprland.enable = true;
    programs.hyprlock.enable = true;

    servises.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    wayland.windowManager.hyprland = {
      settings = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        plugins = [];
        decoration = {
          shadow_offset = "0 5";
          "col.shadow" = "rgba(00000099)";
        };

        "$mod" = "SUPER";

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
      };
    };

    #Apps
    programs.kitty.enable = true;

    environment.systemPackages = with pkgs; [
      hyprpaper
      #kitty
      rofi-wayland
      waybar
      gnome-icon-theme
    ];
  };
}
