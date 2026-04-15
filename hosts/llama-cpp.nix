# tool for testing local network test
{
  pkgs,
  inputs,
  config,
  isHome,
  ...
}: let
  llama-cpp =
    if isHome
    then inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    else pkgs.llama-cpp; # This is now the version from the github repo
in {
  services.llama-cpp = {
    enable = false;
    package = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda;
    model = "/data/ollama/tiny-llm-q8_0.gguf";
  };
  environment.systemPackages = [
    llama-cpp
  ];
}
