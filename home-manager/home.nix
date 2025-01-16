# This is your home-manager configuration file
{
  outputs,
  pkgs,
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

  home.packages = with pkgs; [
    fastfetch
    vlc
    qbittorrent
    inkscape
    gimp
    icomoon-feather
    alsa-utils
    usbutils
    gparted
    # pdf
    # editor
    gedit
    neovim-gtk
  ];

  # enable automount for new drives
  services.udiskie.enable = true;
  services.udiskie.automount = true;
  services.udiskie.notify = true;

  # enable programs
  # TODO: move to own nix file for config
  programs.kitty.enable = true;
  programs.bat.enable = true;
  programs.lsd.enable = true;

  programs.cava.enable = true;
  programs.foot.enable = true;
  programs.btop.enable = true;
  programs.thefuck.enable = true;
  programs.thefuck.enableZshIntegration = true;

  xsession.enable = true;
  xsession.numlock.enable = true;

  fonts.fontconfig.enable = true;

  home.shellAliases = {
    l = "lsd -l";
    ll = "lsd -la";
    lt = "lsd -l --tree";
    t = "lsd --tree";
    llt = "lsd -la --tree";
    cat = "bat";
    ta = "tmux attach";
    nxc-stop = "sudo nixos-container stop";
    nxc-start = "sudo nixos-container start";
    nxc-login = "sudo nixos-container root-login";
    nxc-update = "sudo nixos-container update";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    # QT_STYLE_OVERRIDE = "adwaita-dark";
    # QT_STYLE_OVERRIDE = "adwaita";

    EDITOR = "nvim";

    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
    # SDL_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };

  programs.git = {
    enable = true;
    userName = "Farouk Brown";
    userEmail = "aionoid.xd@gmail.com";
  };

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
