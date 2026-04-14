# tool for testing local network test
{pkgs, ...}: {
  services.llama-cpp = {
    enable = true;
    packages = pkgs.llama-cpp.packages.${pkgs.system}.cuda;
  };
  # environment.systemPackages = [
  #   pkgs.llama-cpp # This is now the version from the github repo
  # ];
}
