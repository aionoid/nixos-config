{...}: {
  programs.nixvim = {
    plugins = {
      markview = {
        enable = true;
        settings = {
          preview = {
            enable = true;
            icon_provider = "devicons";
            filetypes = ["markdown" "codecompanion"];
            ignore_buftypes = ["nofile"];
            # modes = true;
            linewise_hybrid_mode = true;
            hybrid_modes = [
              "i"
              "r"
            ];
            modes = [
              "no"
              "n"
              "t"
              "c"
            ];
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = " ";
        options = {
          desc = "Markdown <?>";
        };
      }
      {
        mode = "n";
        key = "<leader>mt";
        action = "<cmd>Markview Toggle<cr>";
        options = {
          desc = "Markview Toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>ms";
        action = "<cmd>Markview Start<cr>";
        options = {
          desc = "Allows attaching to new buffers.";
        };
      }
      {
        mode = "n";
        key = "<leader>mp";
        action = "<cmd>Markview Stop<cr>";
        options = {
          desc = "Prevents attaching to new buffers.";
        };
      }
      {
        mode = "n";
        key = "<leader>me";
        action = "<cmd>Markview Enable<cr>";
        options = {
          desc = "Enables preview globally.";
        };
      }
      {
        mode = "n";
        key = "<leader>md";
        action = "<cmd>Markview Disable<cr>";
        options = {
          desc = "Disable preview globally.";
        };
      }
      {
        mode = "n";
        key = "<leader>mr";
        action = "<cmd>Markview Render<cr>";
        options = {
          desc = "Updates preview of all active buffers.";
        };
      }
      {
        mode = "n";
        key = "<leader>mc";
        action = "<cmd>Markview Clear<cr>";
        options = {
          desc = "Clears preview of all active buffers.";
        };
      }
      {
        mode = "n";
        key = "<leader>m:";
        action = "";
        options = {
          desc = "Split View.";
        };
      }
      {
        mode = "n";
        key = "<leader>m:c";
        action = "<cmd>Markview splitClose<cr>";
        options = {
          desc = "Closes any open splitview.";
        };
      }
      {
        mode = "n";
        key = "<leader>m:t";
        action = "<cmd>Markview splitToggle<cr>";
        options = {
          desc = "Toggles splitview.";
        };
      }
      {
        mode = "n";
        key = "<leader>m:r";
        action = "<cmd>Markview splitRedraw<cr>";
        options = {
          desc = "Updates splitview contents.";
        };
      }
    ];
  };
}
#SED_WORK

