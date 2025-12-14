# This is your home-manager configuration file
{
  outputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../apps/graphical
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  xdg.userDirs.enable = true;

  home = {
    packages = with pkgs; [
      fastfetch
      vlc
      qbittorrent
      inkscape
      gimp
      icomoon-feather
      alsa-utils
      usbutils
      gparted
      baobab
      lsof
      # pdf
      # editor
      sysstat
      gedit
      #neovim-gtk
      # download helper
      vdhcoapp
      # youtube downloader
      # yt-dlp
      uv # python package manger in Rust
      nodejs # for npx and npm
    ];

    shellAliases = {
      l = "lsd -l";
      # ll = "lsd -la";
      # lt = "lsd -l --tree";
      t = "lsd --tree";
      # llt = "lsd -la --tree";
      cat = "bat";
      ta = "tmux attach";
      tn = "tmux new";
      nxc-stop = "sudo nixos-container stop";
      nxc-start = "sudo nixos-container start";
      nxc-login = "sudo nixos-container root-login";
      nxc-update = "sudo nixos-container update";
      n = "nvim .";
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";

      # QT_STYLE_OVERRIDE = "adwaita-dark";
      # QT_STYLE_OVERRIDE = "adwaita";

      EDITOR = "nvim";

      # GTK_IM_MODULE = "fcitx";
      # QT_IM_MODULE = "fcitx";
      # SDL_IM_MODULE = "fcitx";
      # XMODIFIERS = "@im=fcitx";
    };
  };
  # enable automount for new drives
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  # enable programs
  programs = {
    kitty.enable = true;
    bat.enable = true;
    lsd.enable = true;

    cava.enable = true;
    foot.enable = true;
    btop.enable = true;

    git = {
      enable = true;
      settings = {
        user.name = "Farouk Brown";
        user.email = "aionoid.xd@gmail.com";
      };
    };
  };

  # home.sessionVariables = {
  #   PATH = "$PATH:${config.home.homeDirectory}/.foo/bar";
  # };

  home.sessionPath = [
    "~/.local/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];
  xsession.enable = true;
  xsession.numlock.enable = true;

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
