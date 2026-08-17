{pkgs, ...}: {
  # Define a user account
  # users.extraUsers.kodi.isNormalUser = true;
  # services.cage.user = "kodi";
  # services.cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
  # services.cage.enable = true;
  # Enable the required unfree packages
  # nixpkgs.config.allowUnfree = true;

  # Add inputstream-adaptive to your Kodi packages
  environment.systemPackages = with pkgs; [
    (kodi-wayland.withPackages (kodiPkgs:
      with kodiPkgs; [
        inputstream-adaptive
      ]))
  ];

  # Point Kodi/InputStream to the system's Widevine CDM library
  # home.file.widevine-lib.source = "${pkgs.unfree.widevine-cdm}/share/google/chrome/WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so";
}
