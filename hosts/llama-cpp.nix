# tool for testing local network test
{
  pkgs,
  inputs,
  ...
}: {
  services.llama-cpp = {
    enable = false;
    package = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda;
    model = "/data/ollama/tiny-llm-q8_0.gguf";
  };
  environment.systemPackages = [
    inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    # pkgs.llama-cpp # This is now the version from the github repo
  ];
}
