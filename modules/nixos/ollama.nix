{isHome ? false, ...}: {
  services.ollama = {
    enable = true;
    # package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.ollama;
    # package =
    #   if isHome
    #   then pkgs.ollama-cuda
    #   else pkgs.ollama;
    environmentVariables = {
      # Enable all available GPUs
      OLLAMA_GPU_LAYERS = "-1";

      # Set GPU memory allocation (99% of total VRAM)
      OLLAMA_GPU_MEMORY_FRACTION = "1";

      # Specify GPU devices (optional - auto-detect by default)
      #CUDA_VISIBLE_DEVICES = "0,1";

      # Enable tensor parallelism for supported models
      OLLAMA_TENSOR_PARALLEL = "true";

      # Set maximum concurrent requests
      OLLAMA_MAX_CONCURRENT_REQUESTS = "4";

      # Configure GPU communication method
      OLLAMA_GPU_COMMUNICATION = "p2p";

      # Set specific memory limits per GPU
      OLLAMA_GPU_0_MEMORY = "24GB";
      OLLAMA_GPU_1_MEMORY = "7GB";
    };

    #INFO: need folder permission to work: chmod 775 -R
    # and set group to ollama
    models =
      if isHome
      then "/data/ollama/models"
      else "/mnt/DISK/ollama/models";
  };
}
