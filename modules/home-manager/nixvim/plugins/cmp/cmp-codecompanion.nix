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
                     adapter = "gemma3",
                     -- adapter = "domo",
                   },
                   inline = {
                     adapter = "gemma3",
                     -- adapter = "domo",
                   },
                 },
       display = {
        action_palette = {
          provider = "telescope",
          },
        },
       adapters = {
             deepseek8b = function()
               return require("codecompanion.adapters").extend("ollama", {
                 name = "deepseek8b", -- Give this adapter a different name to differentiate it from the default ollama adapter
                 schema = {
                   model = {
                     default = "deepseek-r1:8b",
                   },
                 },
               })
             end,
             gemma3= function()
               return require("codecompanion.adapters").extend("ollama", {
                 name = "gemma3", -- Give this adapter a different name to differentiate it from the default ollama adapter
                 schema = {
                   model = {
                     default = "gemma3:4b",
                   },
                 },
               })
             end,
             domo = function()
               return require("codecompanion.adapters").extend("ollama", {
                 name = "domo",
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

