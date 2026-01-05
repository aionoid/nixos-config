{
  pkgs,
  lib,
  stylix,
  ...
}: {
  imports = [
    ../theme.nix
  ];

  #TODO: move to theme folder
  gtk = {
    enable = true;
    iconTheme = {
      # name = "Obsidian-Aqua";
      # package = pkgs.iconpack-obsidian;
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    qt6ctSettings = {
      Appearance = {
        style = "kvantum-dark";
        icon_theme = "kora";
        standar_dialogs = "default";
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font Mono,12\"";
        general = "\"DejaVu Sans,12\"";
        # fixed = "\"Roboto Mono [GOOG],12\"";
        # general = "\"Roboto,12\"";
      };
    };
    qt5ctSettings = {
      Appearance = {
        style = "kvantum-dark";
        icon_theme = "kora";
        standar_dialogs = "default";
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font Mono,12\"";
        general = "\"DejaVu Sans,12\"";
        # fixed = "\"Roboto Mono [GOOG],12\"";
        # general = "\"Roboto,12\"";
      };
    };
  };

  stylix.targets = {
    noctalia-shell.enable = true;
    zen-browser = {
      enable = false;
      profileNames = [
        "default"
      ];
    };
    librewolf = {
      enable = true;
      profileNames = [
        "default"
        # "work"
      ];
    };
    firefox = {
      enable = true;
      profileNames = [
        "default"
        # "work"
      ];
    };
  };
}
