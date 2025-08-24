{
  pkgs,
  isHome ? false,
  ...
}: {
  services.ollama = {
    enable = true;
    # package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.ollama;
    # package =
    #   if isHome
    #   then pkgs.ollama-cuda
    #   else pkgs.ollama;
    #INFO: need folder permission to work: chmod 777 -R
    models =
      if isHome
      then "/data/ollama/models"
      else "/mnt/DISK/ollama/models";
  };
}
