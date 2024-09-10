{lib, ...}: {
  imports = [
    ./hypr.nix
  ];

  ovo.hyprland.enable = lib.mkDefault false;
}
