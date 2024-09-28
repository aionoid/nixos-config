{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./nvidia.nix

    ../global.nix
    # desktop manager
    # ../xfce.nix
    ../hyprland.nix
  ];
  networking.hostName = "home";
  # set defaultUserShell for all users
  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ovo = {
    isNormalUser = true;
    description = "ovo";
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "users" "pipewire" "input"];
    useDefaultShell = true;
    # packages = with pkgs; [];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
