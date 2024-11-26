{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../theme.nix
  ];

  #TODO: move to theme folder
  gtk = {
    enable = true;
    iconTheme = {
      name = "Obsidian-Aqua";
      package = pkgs.iconpack-obsidian;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # stylix.targets.waybar.enable = false;
  # stylix.targets.hyprpaper.enable = lib.mkForce false;
}
