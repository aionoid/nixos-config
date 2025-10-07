{...}: {
  programs.nvf = {
    settings.vim = {
      assistant = {
        avante-nvim = {
          enable = true;
          setupOpts = {
            provider = "ollama";
            # for v0.0.24^
            providers = {
              ollama = {
                model = "qwen25coder:7bq4kl";
              };
              glm4 = {
                __inherited_from = "ollama";
                model = "glm4:q4xl";
              };
              qwen3coder = {
                __inherited_from = "ollama";
                model = "qwen3coder:q4xl";
              };
            };
            # qwen_nvim = {
            #   model = "qwen2.5-coder-ins-unc:nvim";
            # };
          };
        };
      };
    };
  };
}
