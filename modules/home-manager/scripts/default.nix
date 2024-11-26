{pkgs, ...}: {
  # wallpaperChange = pkgs.writeShellScriptBin "wallpaperChange"
  home.packages = with pkgs; [
    (writeShellScriptBin "scriptChangeWallpaper" (builtins.readFile ./changeWallpaper.sh))
    (writeShellScriptBin "rofi_launcher" (builtins.readFile ./launchers.sh))
    (writeShellScriptBin "rofi_apps" (builtins.readFile ./apps.sh))
    (writeShellScriptBin "rofi_appasroot" (builtins.readFile ./appasroot.sh))
    (writeShellScriptBin "rofi_music" (builtins.readFile ./mpd.sh))
    (writeShellScriptBin "rofi_powermenu" (builtins.readFile ./powermenu.sh))
    (writeShellScriptBin "rofi_quicklinks" (builtins.readFile ./quicklinks.sh))
    (writeShellScriptBin "rofi_screenshot" (builtins.readFile ./screenshot.sh))
    (writeShellScriptBin "rofi_volume" (builtins.readFile ./volume.sh))
    (writeShellScriptBin "colorpicker" (builtins.readFile ./colorpicker.sh))
    (writeShellScriptBin "terminal" (builtins.readFile ./terminal.sh))
  ];
}
