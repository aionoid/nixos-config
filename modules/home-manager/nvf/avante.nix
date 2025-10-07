{...}: {
  programs.nvf = {
    settings.vim = {
      assistant = {
        avante-nvim = {
          enable = true;
          setupOpts = {
            debug = false;
            provider = "llama_cpp";
            providers = {
              llama_cpp = {
                __inherited_from = "openai";
                endpoint = "http://127.0.0.1:8080/v1";
                # model = "GLM-4-32B-0414-UD-Q4_K_XL.gguf";
                # model = "GLM-4-9B-0414-Q4_K_M.gguf";
                # model = "GLM-4-9B-0414-UD-Q4_K_XL.gguf";
                model = "Qwen3-4B-Instruct-2507-UD-Q4_K_XL.gguf";
                api_key_name = "";
                stream = true;
              };
              lmstudio = {
                __inherited_from = "openai";
                endpoint = "http://127.0.0.1:1234/v1";
                # model = "glm-4/GLM-4-9B-0414-Q4_K_M.gguf";
                # model = "qwen2.5";
                model = "unsloth/qwen3/qwen3-4b-instruct-2507-ud-q4_k_xl.gguf";
                api_key_name = "";
                stream = true;
              };
            };
          };
        };
      };
    };
  };
}
