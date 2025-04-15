{...}: {
  programs.nixvim = {
    plugins.avante = {
      enable = true;
      settings = {
        provider = "ollama";
        # ollama = {
        #   endpoint = "http://127.0.0.1:11434";
        #   model = "qwen2.5-coder:0.5b";
        # };
        vendors = {
          ollama = {
            # endpoint = "http://127.0.0.1:11434";
            model = "qwen2.5-coder:0.5b";
            __inherited_from = "openai";
            api_key_name = "";
            endpoint = "http://127.0.0.1:11434/v1";
            max_tokens = 4096;
            #-- important to set this to true if you are using a local server
            disable_tools = true;
          };
        };
      };
    };
    keymaps = [
      # {
      #   mode = ["n" "v"];
      #   key = "<C-a>";
      #   action = "<cmd>CodeCompanionActions<cr>";
      #   options = {
      #     desc = "CodeCompanion Actions";
      #     noremap = true;
      #     silent = true;
      #   };
      # }
      {
        mode = "n";
        key = "<leader>a";
        action = " ";
        options = {
          desc = "Avante AI <?>";
        };
      }
      # {
      #   mode = "v";
      #   key = "ga";
      #   action = "<cmd>CodeCompanionChat Add<cr>";
      #   options = {
      #     desc = "CodeCompanion Chat Add";
      #     noremap = true;
      #     silent = true;
      #   };
      # }
    ];

    extraConfigLua = ''
      -- require('avante').setup ({
      --   -- Your config here!
      --   provider = "ollama",
      --   ollama = {
      --     endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
      --     model = "qwen2.5-coder:0.5b",
      --   },
      -- })
    '';
  };
}
