{pkgs, ...}: {
  # wallpaperChange = pkgs.writeShellScriptBin "wallpaperChange"
  home.packages = with pkgs; [
    (writeShellScriptBin "scriptChangeWallpaper" (builtins.readFile ./changeWallpaper.sh))
  ];
}
