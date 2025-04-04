{inputs, ...}: {
  services.ollama = {
    enable = true;
    # package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.ollama;
  };
}
