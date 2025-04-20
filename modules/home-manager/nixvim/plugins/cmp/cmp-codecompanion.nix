{...}: {
  programs.nixvim = {
    plugins.codecompanion = {
      enable = true;
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<C-a>";
        action = "<cmd>CodeCompanionActions<cr>";
        options = {
          desc = "CodeCompanion Actions";
          noremap = true;
          silent = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>a";
        action = "<cmd>CodeCompanionChat Toggle<cr>";
        options = {
          desc = "CodeCompanion Chat Toggle";
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "v";
        key = "ga";
        action = "<cmd>CodeCompanionChat Add<cr>";
        options = {
          desc = "CodeCompanion Chat Add";
          noremap = true;
          silent = true;
        };
      }
    ];

    extraConfigLua =
      /*
      lua
      */
      ''
        require("codecompanion").setup({
         opts = {
           log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
         },
         strategies = {
                     chat = {
                       adapter = "qwen_coder",
                     },
                     inline = {
                       adapter = "qwen_coder",
                     },
                   },
         display = {
          action_palette = {
            provider = "telescope",
            },
          },
         adapters = {
               deepseek = function()
                 return require("codecompanion.adapters").extend("ollama", {
                   name = "deepseek-r1u-8b", -- Give this adapter a different name to differentiate it from the default ollama adapter
                   schema = {
                     model = {
                       default = "deepseek-r1u:8b",
                     },
                   },
                 })
               end,
               gemma3= function()
                 return require("codecompanion.adapters").extend("ollama", {
                   name = "gemma3u-4b",
                   schema = {
                     model = {
                       default = "gemma3u:4b",
                     },
                   },
                 })
               end,
               qwen_coder= function()
                 return require("codecompanion.adapters").extend("ollama", {
                   name = "QwenCoder",
                   schema = {
                     model = {
                       default = "qwen2.5u-coder:7b",
                     },
                   },
                 })
               end,
             },
        })
        vim.cmd([[cab cc CodeCompanion]])
      '';
  };
}
#SED_WORK

