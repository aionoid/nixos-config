{lib, ...}: {
  programs.nvf.settings.vim = {
    assistant.codecompanion-nvim = {
      enable = true;
      setupOpts = {
        strategies.chat.adapter = "qwen_coder";
        strategies.inline.adapter = "qwen_coder";
        opts = {
          log_level = "DEBUG";
        };
        adapters =
          lib.mkLuaInline
          /*
          lua
          */
          ''
            -- require("codecompanion").setup({
            --  adapters =
                        {
                            deepseek = function()
                              return require("codecompanion.adapters").extend("ollama", {
                                name = "deepseek-r1u-8b",
                                schema = {
                                  model = {
                                    default = "deepseek-r1u:8b",
                                  },
                                },
                              })
                            end,
                            gemma3 = function()
                              return require("codecompanion.adapters").extend("ollama", {
                                name = "gemma3u-4b",
                                schema = {
                                  model = {
                                    default = "gemma3u:4b",
                                  },
                                },
                              })
                            end,
                            qwen_coder = function()
                              return require("codecompanion.adapters").extend("ollama", {
                                name = "QwenCoder",
                                schema = {
                                  model = {
                                    default = "qwen25u-coder:7b",
                                  },
                                },
                              })
                            end,
                          }
                  -- })
                  -- vim.cmd([[cab cc CodeCompanion]])
          '';
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<C-a>";
        action = "<cmd>CodeCompanionActions<cr>";
        desc = "CodeCompanion Actions";
        noremap = true;
        silent = true;
      }
      {
        mode = ["n" "v"];
        key = "<leader>a";
        action = "<cmd>CodeCompanionChat Toggle<cr>";
        desc = "CodeCompanion Chat Toggle";
        noremap = true;
        silent = true;
      }
      {
        mode = "v";
        key = "ga";
        action = "<cmd>CodeCompanionChat Add<cr>";
        desc = "CodeCompanion Chat Add";
        noremap = true;
        silent = true;
      }
    ];
  };
}
