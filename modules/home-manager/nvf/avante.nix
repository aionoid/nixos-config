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
                model = "qwen2.5-coder-ins-unc:nvim";
              };
              ollama_qwen_7b_q6 = {
                __inherited_from = "ollama";
                model = "qwen2.5u-coder:7b";
              };
              ollama_ds_8b_q6 = {
                __inherited_from = "ollama";
                model = "deepseek-r1u:8b";
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
