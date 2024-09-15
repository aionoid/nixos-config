{
  inputs,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    #   # inputs.stylix.nixosModules.stylix
    #   # # use as modeule ?
    #   # ../modules/nixos/theme.nix
    #
    #   # inputs.home-manager.nixosModules.home-manager
    #   # {
    #   #   home-manager.useGlobalPkgs = true;
    #   #   home-manager.useUserPackages = true;
    #   #   # home-manager.users.antiroot = import ./home.nix;
    #   # }
  ];
  # home-manager = {
  #   extraSpecialArgs = {inherit inputs outputs;};
  #   users = {
  #     # Import your home-manager configuration
  #     antiroot = import [../home-manager/home.nix ../home-manager/antiroot.nix];
  #     ovo = import [../home-manager/home.nix ../home-manager/ovo.nix];
  #   };
  # };
  hardware.graphics.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Install firefox.adb,dconf,zsh
  programs = {
    adb.enable = true;
    dconf.enable = true;
    firefox.enable = true;
    zsh.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    nodePackages.gitmoji-cli
    home-manager
    inputs.nixvim.packages.x86_64-linux.default
    #TODO: config nix tool  nh
    nh
    # icon theme
    gnome-icon-theme
  ];

  # Enable networking
  networking.networkmanager.enable = true;

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
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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

  environment.sessionVariables = {
    FLAKE = "/etc/nixos";
  };

  environment.variables = {
    FLAKE = "/etc/nixos";
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  system.stateVersion = "24.11";
}
