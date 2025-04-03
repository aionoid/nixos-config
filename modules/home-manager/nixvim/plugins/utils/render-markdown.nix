{...}: {
  programs.nixvim = {
    plugins = {
      render-markdown = {
        enable = true;
        settings = {
          enabled = true;
          completions = {lsp = {enabled = true;};};
          file_types = ["md" "markdown" "codecompanion"];
          ft = ["markdown" "codecompanion"];
          render_modes = true;
          # render_modes = ["n" "c" "t"];
          # overrides = {
          #   buftype = {};
          #   filetypes = {};
          # };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = " ";
        options = {
          desc = "Render-Markdown <?>";
        };
      }
      # Sub Command : Current Buffer
      {
        mode = "n";
        key = "<leader>mb";
        action = " ";
        options = {
          desc = "Current Buffer <?>";
        };
      }
      # :RenderMarkdown buf_enable 	Enable this plugin for current buffer
      {
        mode = "n";
        key = "<leader>mbe";
        action = "<cmd>RenderMarkdown buf_enable<cr>";
        options = {
          desc = "Enable this plugin for current buffer";
        };
      }
      # :RenderMarkdown buf_disable Disable this plugin for current buffer
      {
        mode = "n";
        key = "<leader>mbd";
        action = "<cmd>RenderMarkdown buf_disable<cr>";
        options = {
          desc = "Disable this plugin for current buffer";
        };
      }
      # :RenderMarkdown buf_toggle 	Toggle state of this plugin for current buffer
      {
        mode = "n";
        key = "<leader>mbt";
        action = "<cmd>RenderMarkdown buf_toggle<cr>";
        options = {
          desc = "Toggle state of this plugin for current buffer";
        };
      }
      # :RenderMarkdown	            Enable this plugin
      # :RenderMarkdown enable      Enable this plugin
      {
        mode = "n";
        key = "<leader>me";
        action = "<cmd>RenderMarkdown enable<cr>";
        options = {
          desc = "Enable this plugin";
        };
      }
      # :RenderMarkdown toggle 	    Toggle state of this plugin
      {
        mode = "n";
        key = "<leader>mt";
        action = "<cmd>RenderMarkdown toggle<cr>";
        options = {
          desc = "Toggle state of this plugin";
        };
      }
      # :RenderMarkdown disable 	  Disable this plugin
      {
        mode = "n";
        key = "<leader>md";
        action = "<cmd>RenderMarkdown disable<cr>";
        options = {
          desc = "Disable this plugin";
        };
      }
      # :RenderMarkdown log 	    l  Opens the log file for this plugin
      {
        mode = "n";
        key = "<leader>ml";
        action = "<cmd>RenderMarkdown log<cr>";
        options = {
          desc = "Opens the log file for this plugin";
        };
      }
      # :RenderMarkdown expand 	  x  Increase anti-conceal margin above and below by 1
      {
        mode = "n";
        key = "<leader>mx";
        action = "<cmd>RenderMarkdown expand<cr>";
        options = {
          desc = "Increase anti-conceal margin above and below by 1";
        };
      }
      # :RenderMarkdown contract 	r  Decrease anti-conceal margin above and below by 1
      {
        mode = "n";
        key = "<leader>mr";
        action = "<cmd>RenderMarkdown contract<cr>";
        options = {
          desc = "Decrease anti-conceal margin above and below by 1";
        };
      }
      # :RenderMarkdown debug 	  g  Prints information about marks on current line
      {
        mode = "n";
        key = "<leader>mg";
        action = "<cmd>RenderMarkdown debug<cr>";
        options = {
          desc = "Prints information about marks on current line";
        };
      }
      # :RenderMarkdown config 	  c  Prints difference between config and default
      {
        mode = "n";
        key = "<leader>mc";
        action = "<cmd>RenderMarkdown config<cr>";
        options = {
          desc = "Prints difference between config and default";
        };
      }
    ];
  };
}
#SED_WORK

