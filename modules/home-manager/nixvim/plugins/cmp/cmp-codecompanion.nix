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

    extraConfigLua = ''
      require("codecompanion").setup({
       strategies = {
                   chat = {
                     adapter = "qwen_coder",
                     -- adapter = "domo",
                   },
                   inline = {
                     adapter = "qwen_coder",
                     -- adapter = "domo",
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
                 name = "gemma3u-4b", -- Give this adapter a different name to differentiate it from the default ollama adapter
                 schema = {
                   model = {
                     default = "gemma3u:4b",
                   },
                 },
               })
             end,
             qwen_coder= function()
               return require("codecompanion.adapters").extend("ollama", {
                 name = "qwen2.5u-coder-7b", -- Give this adapter a different name to differentiate it from the default ollama adapter
                 schema = {
                   model = {
                     default = "qwen2.5u-coder:7b",
                   },
                 },
               })
             end,
             domo = function()
               return require("codecompanion.adapters").extend("ollama", {
                 name = "",
                 schema = {
                   model = {
                     default = "DOMO:DS14B6Q",
                   },
                   -- num_ctx = {
                   --   default = 16384,
                   -- },
                   -- num_predict = {
                   --   default = -1,
                   -- },
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

