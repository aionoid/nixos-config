{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
}
