{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./nvidia.nix
    ./disko-config.nix
    ./printer.nix

    ../global.nix
    # desktop manager
    # ../xfce.nix
    ../hyprland.nix
    # greeter
    ../greetd.nix
    # ../sddm.nix
    ## boot theme
    ../plymouth.nix
    ## containers
    ../containers
    ## rgb controle
    ../openrgb.nix
    ../waydroid.nix
    ## obs-studio
    # ../obs.nix
    ## VM
    ../vm.nix
    ## office
    # ../office.nix
    ../podman.nix
    # AI
    ../llama-cpp.nix
  ];
  networking.hostName = "home";
  # set defaultUserShell for all users
  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ovo = {
    isNormalUser = true;
    description = "ovo";
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "users" "pipewire" "input" "ollama" "i2c" "lp" "lpadmin" "podman" "docker"];
    useDefaultShell = true;
    # packages = with pkgs; [];
  };

  environment.sessionVariables = {
    # GTK_USE_PORTAL = "1";
    # AQ_DRM_DEVICES = "/dev/dri/by-path/pci-0000:05:00.0-card:/dev/dri/by-path/pci-0000:0b:00.0-card";
    # WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:05:00.0-card:/dev/dri/by-path/pci-0000:0b:00.0-card";
    AQ_DRM_DEVICES = "/var/card3070:/var/card3090";
    WLR_DRM_DEVICES = "/var/card3070:/var/card3090";

    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # LIBVA_DRIVER_NAME = "nvidia";
    # WLR_NO_HARDWARE_CURSORS = "1";
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
