{lib, ...}: {
  programs.nvf.settings.vim = {
    assistant.codecompanion-nvim = {
      enable = true;
      setupOpts = {
        display.chat.show_settings = true;
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
                        default = "qwen2.5u-coder:7b",
                      },
                    },
                  })
                end,
              }
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
    # vim.cmd([[cab cc CodeCompanion]])
    # lazy.plugins.codecompanion-nvim.cmd = ["[cab cc CodeCompanion]"]; load on command
    lazy.plugins.codecompanion-nvim.after =
      /*
      lua
      */
      ''
        vim.cmd([[cab cc CodeCompanion]])
      '';
  };
}
