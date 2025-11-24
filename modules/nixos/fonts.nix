{
  config,
  pkgs,
  lib,
  ...
}:
# }: let
#   fontsOverlay = import (
#     builtins.fetchTarball {
#       url = "https://github.com/Soft/nix-google-fonts-overlay/archive/master.tar.gz";
#       sha256 = "067ws05gk60al1ihiwwan2vbfjlm61d6m50qk9smb89fkmfi4z4n";
#     }
#   );
# in
{
  # nixpkgs.overlays = [fontsOverlay];

  fonts.packages = with pkgs; [
    # google-fonts-reem-kufi
    # google-fonts-aref-ruqaa
    noto-fonts
    noto-fonts-cjk-serif
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    google-fonts
    icomoon-feather
    kacst
    # google-fonts.override
    # {fonts = ["reem-kufi" "aref-ruqaa"];}
  ];
}
