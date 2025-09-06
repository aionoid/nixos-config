{pkgs, ...}: {
  services.hardware.openrgb.enable = true;
  hardware.i2c.enable = true;
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    i2c-tools
    rwedid
  ];
  services.udev.packages = [pkgs.rwedid pkgs.openrgb-with-all-plugins];
  boot.initrd.kernelModules = ["i2c-dev"];
  boot.kernelModules = ["i2c-nvidia-gpu"];
}
