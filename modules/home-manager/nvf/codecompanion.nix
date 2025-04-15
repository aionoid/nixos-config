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
            {
                deepseek = function()
                  return require(" codecompanion.adapters ").extend(" ollama ", {
                    name = " deepseek-r1u-8b ", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                      model = {
                        default = " deepseek-r1u:8b ",
                      },
                    },
                  })
                end,
                gemma3= function()
                  return require(" codecompanion.adapters ").extend(" ollama ", {
                    name = " gemma3u-4b ", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                      model = {
                        default = " gemma3u:4b ",
                      },
                    },
                  })
                end,
                qwen_coder= function()
                  return require(" codecompanion.adapters ").extend(" ollama ", {
                    name = " QwenCoder ", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                      model = {
                        default = " qwen25u-coder:7b ",
                      },
                    },
                  })
                end,
                domo = function()
                  return require(" codecompanion.adapters ").extend(" ollama ", {
                    name = " ",
                    schema = {
                      model = {
                        default = " DOMO:DS14B6Q ",
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
              }
          '';
      };
    };
  };
}
