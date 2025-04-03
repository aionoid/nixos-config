{inputs, ...}: {
  services.open-webui = {
    enable = true;
    #FIXME: unis unstable pakgs as a workaround
    package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.open-webui;
    # openFirewall = true;
  };
}
