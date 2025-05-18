{
  pkgs,
  config,
  ...
}: {
  # programs.steam.enable = true;
  # programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    # protonup
    # mangohud
    # lutris
    # heroic
    bottles
    # wineWowPackages.waylandFull
    # winetricks
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;
  # home.packages = with pkgs; [
  # ];
}
