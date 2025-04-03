{inputs, ...}: {
  services.ollama = {
    enable = true;
    # FIXME: use future nixpkgs version unstable
    package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.ollama;
  };
}
