{pkgs, ...}: {
  imports = [
  ];
  hardware.graphics.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.autoUpgrade.channel = "https://nixos.org/channels/nixpkgs-unstable";

  # Install firefox.adb,dconf,zsh
  programs = {
    git.enable = true;
    adb.enable = true;
    dconf.enable = true;
    firefox.enable = true;
    zsh.enable = true;
  };

  # enable AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # enable nix-ld
  programs.nix-ld = {
    enable = true;
  };

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      uv # python package manger in Rust
      nodePackages.gitmoji-cli
      home-manager
      # inputs.nixvim.packages.x86_64-linux.default
      # (inputs.nixvim.packages.x86_64-linux.default.override {
      #   plugins.nvim-colorizer.enable = true;
      # })
      #setting FLAKE=/etc/nixos/ config for nh
      nh
      # icon theme
      gnome-icon-theme
      # ntfs tools
      ntfs3g
      dosfstools
      ntfsprogs
      #scrounge-ntfs
      #ntfs2btrfs
      #MTP fs
      jmtpfs
    ];
    sessionVariables = {
      NH_FLAKE = "/etc/nixos";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    variables = {
      NH_FLAKE = "/etc/nixos";
      # GTK_DEBUG = "interactive";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [networkmanager-openvpn];

  # Set your time zone.
  time.timeZone = "Africa/Algiers";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # Enable CUPS to print documents.
  services = {
    printing.enable = true;

    # Enable disks mount with Udisk
    udisks2.enable = true;
    # services.udisks2.mountOnMedia = true;

    # enable MTP devices
    gvfs.enable = true;

    # GPU Info/Controle/Monitor temp,fan,OC
    lact.enable = true;
  };

  # Enable Gnome Disks
  programs.gnome-disks.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  systemd.targets.hibernate.enable = false;

  # dconf.settings = {
  #   "org.gtk.Settings.Debug" = {
  #     "enable-inspector-keybinding" = true;
  #   };
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  system.stateVersion = "24.11";
}
