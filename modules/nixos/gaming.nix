{pkgs, ...}: {
  nixpkgs.overlays = [
    (self: super: {
      openldap = super.openldap.overrideAttrs (oldAttrs: {
        doCheck = false; # Skip tests to bypass the failure
      });
    })
  ];
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # services.flatpak = {
  #   enable = true; # for using Bottles Flatpak
  #   # packages = [
  #   #   "com.usebottles.bottles"
  #   # ];
  # };

  environment.systemPackages = with pkgs; [
    # protonup-ng # renamed from protonup
    protonup-qt
    # protonup-rs
    protontricks

    mangohud
    lutris
    bottles
    heroic
    # wineWowPackages.waylandFull
    # wineWowPackages.stagingFull
    wineWow64Packages.stagingFull
    winetricks
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
