{
  lib,
  pkgs,
  ...
}: {
  programs.nvf = {
    settings.vim = {
      assistant = {
        avante-nvim = {
          enable = true;
          setupOpts = {
            provider = "ollama";
            # for v0.0.24^
            ollama = {
              model = "qwen2.5u-coder:7b";
            };
            #-- Working Ollama configuration ver v0.0.23
            # vendors = {
            #   ollama = {
            #     __inherited_from = "openai";
            #     api_key_name = "";
            #     endpoint = "http://127.0.0.1:11434/v1";
            #     model = "qwen2.5u-coder:7b";
            #     max_tokens = 4096;
            #     #-- important to set this to true if you are using a local server
            #     disable_tools = true;
            #   };
            #   ollama_ds = {
            #     __inherited_from = "openai";
            #     api_key_name = "";
            #     endpoint = "http://127.0.0.1:11434/v1";
            #     model = "deepseek-r1u:7b";
            #     max_tokens = 4096;
            #     #-- important to set this to true if you are using a local server
            #     disable_tools = true;
            #   };
            # };
          };
        };
      };
    };
  };
}
