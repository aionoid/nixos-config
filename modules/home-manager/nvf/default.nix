{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    # ghostscript # for pdf render used by Snacks.image
    # tectonic # or pdflatex to render LaTeX for Snacks.image
    # mermaid-cli # to render Mermaid diagrams for Snacks.image
    # sqlite # for Snacks.picker
    # python3Packages.pylatexenc # pylatexenc for render-markdown
    tree-sitter
    ripgrep
    fd
    gcc
  ];

  imports = [
    ./keymaps.nix
    ./theme.nix
    ./mini.nix
    # ./codecompanion.nix
    ./avante.nix
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      spellcheck = {
        enable = true;
      };

      lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = false; #isMaximal;
        nvim-docs-view.enable = false; #isMaximal;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      # This section does not include a comprehensive list of available language modules.
      # To list all available language module options, please visit the nvf manual.
      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Languages that will be supported in default and maximal configurations.
        nix.enable = true;
        markdown = {
          enable = true;
          extensions.render-markdown-nvim = {
            enable = true;
            setupOpts = {
              file_types = ["markdown" "marksman" "codecompanion"];
              completions = {lsp = {enabled = true;};};
            };
          };
        };
        yaml.enable = true;

        # Languages that are enabled in the maximal configuration.
        bash.enable = true; #isMaximal;
        clang.enable = false; #isMaximal;
        css.enable = true; #isMaximal;
        html.enable = true; #isMaximal;
        sql.enable = false; #isMaximal;
        java.enable = false; #isMaximal;
        kotlin.enable = false; #isMaximal;
        ts.enable = false; #isMaximal;
        go.enable = false; #isMaximal;
        lua.enable = true; #isMaximal;
        zig.enable = false; #isMaximal;
        python.enable = true; #isMaximal;
        typst.enable = false; #isMaximal;
        rust = {
          enable = false; #isMaximal;
          crates.enable = false; #isMaximal;
        };

        # Language modules that are not as common.
        assembly.enable = false;
        astro.enable = false;
        nu.enable = false;
        csharp.enable = false;
        julia.enable = false;
        vala.enable = false;
        scala.enable = false;
        r.enable = false;
        gleam.enable = false;
        dart.enable = false;
        ocaml.enable = false;
        elixir.enable = false;
        haskell.enable = false;
        ruby.enable = false;
        fsharp.enable = false;

        tailwind.enable = false;
        svelte.enable = false;

        # Nim LSP is broken on Darwin and therefore
        # should be disabled by default. Users may still enable
        # `vim.languages.vim` to enable it, this does not restrict
        # that.
        # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
        nim.enable = false;
      };

      visuals = {
        nvim-scrollbar.enable = false; #isMaximal;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;

        # Fun
        cellular-automaton.enable = false;
      };

      statusline = {
        lualine = {
          enable = true;
        };
      };

      autopairs.nvim-autopairs.enable = true;

      autocomplete.nvim-cmp = {
        enable = true;
        sourcePlugins = [
          # "cmp-buffer"
          # "cmp-luasnip"
          # "cmp-nvim-lsp"
          # "cmp-path"
          # "cmp-treesitter"
          # "codecompanion-nvim"
          "render-markdown-nvim"
        ];
        sources = {
          buffer = "[Buffer]";
          nvim-cmp = "[Nvim_lsp]";
          path = "[Path]";
          render-markdown-nvim = "[render-markdown]";
        };
      };

      snippets.luasnip = {
        enable = true;
        setupOpts = {
          kind_icons = {
            Text = "󰊄";
            Method = " ";
            Function = "󰡱 ";
            Constructor = " ";
            Field = " ";
            Variable = "󱀍 ";
            Class = " ";
            Interface = " ";
            Module = "󰕳 ";
            Property = " ";
            Unit = " ";
            Value = " ";
            Enum = " ";
            Keyword = " ";
            Snippet = " ";
            Color = " ";
            File = "";
            Reference = " ";
            Folder = " ";
            EnumMember = " ";
            Constant = " ";
            Struct = " ";
            Event = " ";
            Operator = " ";
            TypeParameter = " ";
          };
        };
      };

      filetree = {
        neo-tree = {
          enable = true;
          setupOpts = {
            filesystem = {
              follow_current_file.enabled = true;
            };
            default_component_configs = {
              indent = {
                with_expanders = true;
                expander_collapsed = "󰅂";
                expander_expanded = "󰅀";
                expander_highlight = "NeoTreeExpander";
              };

              git_status = {
                symbols = {
                  added = " ";
                  conflict = "󰩌 ";
                  deleted = "󱂥";
                  ignored = " ";
                  modified = " ";
                  renamed = "󰑕";
                  staged = "󰩍";
                  unstaged = "";
                  untracked = " ";
                };
              };
            };
          };
        };
      };

      tabline = {
        nvimBufferline.enable = true;
      };

      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;
      telescope.mappings = {
        buffers = "<leader>b";
        # diagnostics = "";
        liveGrep = "<leader>/";
        findFiles = "<leader><space>";
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      minimap = {
        minimap-vim.enable = false;
        codewindow.enable = false; #isMaximal; # lighter, faster, and uses lua for configuration
      };

      dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = false; #isMaximal;
      };

      notify = {
        nvim-notify.enable = true;
      };

      projects = {
        project-nvim.enable = false; #isMaximal;
      };

      utility = {
        snacks-nvim.enable = true;
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        icon-picker.enable = false; #isMaximal;
        surround.enable = false; #isMaximal;
        leetcode-nvim.enable = false; #isMaximal;
        multicursors.enable = false; #isMaximal;

        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = false; #isMaximal;
        };
        images = {
          image-nvim.enable = false;
        };
      };

      notes = {
        obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
        neorg.enable = false;
        orgmode.enable = false;
        mind-nvim.enable = false; #isMaximal;
        todo-comments.enable = true;
      };

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false; # the theme looks terrible with catppuccin
        illuminate.enable = true;
        breadcrumbs = {
          enable = false; #isMaximal;
          navbuddy.enable = false; #isMaximal;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            # this is a freeform module, it's `buftype = int;` for configuring column position
            nix = "110";
            ruby = "120";
            java = "130";
            go = ["90" "130"];
          };
        };
        fastaction.enable = true;
      };

      lazy.plugins.render-markdown-nvim.ft = ["marksman" "markdown"];

      session = {
        nvim-session-manager.enable = false;
      };

      gestures = {
        gesture-nvim.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence = {
        neocord.enable = false;
      };
    };
  };
}
