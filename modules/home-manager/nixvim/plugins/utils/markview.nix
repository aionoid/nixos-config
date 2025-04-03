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
    # CMD             key    Desc
    # Start 	        -ms    Allows attaching to new buffers.
    # Stop 	          -mp    Prevents attaching to new buffers.
    # Enable 	        -me    Enables preview globally.
    # Disable         -md    Disables preview globally.
    # Toggle 	        -mt    Toggles preview globally.
    # Render 	        -mr    Updates preview of all active buffers.
    # Clear 	        -mc    Clears preview of all active buffer.
    # HybridEnable 	  -mhE   Enables hybrid mode.
    # HybridDisable 	-mhD   Disables hybrid mode.
    # HybridToggle 	  -mhT   Toggles hybrid mode.
    # hybridEnable 	  -mhe   Enables hybrid mode for buffer.
    # hybridDisable 	-mhd   Disables hybrid mode for buffer.
    # hybridToggle 	  -mht   Toggles hybrid mode for buffer.
    # enable 	        -mbe   Enables preview for buffer.
    # disable 	      -mbl   Disables preview for buffer.
    # toggle 	        -mbt   Toggles preview for buffer.
    # attach 	        -mba   Attaches to buffer.
    # detach 	        -mbd   Detaches from buffer.
    # render 	        -mbr   Renders preview for buffer.
    # clear 	        -mbc   Clears preview for buffer.
    # linewiseEnable 	-mle   Enables linewise hybrid mode.
    # linewiseDisable -mld   Disables linewise hybrid mode.
    # linewiseToggle 	-mlt   Toggles linewise hybrid mode.
    # splitOpen 	    -mso   Opens splitview for buffer.
    # splitClose 	    -msc   Closes any open splitview.
    # splitToggle 	  -mst   Toggles splitview.
    # splitRedraw 	  -msr   Updates splitview contents.
    # traceExport     -mte   Exports trace logs to trace.txt.
    # traceShow 	    -mts   Shows trace logs in a window.
    # toggleAll 	    -      Deprecated version of Toggle.
    # enableAll 	    -      Deprecated version of Enable.
    # disableAll 	    -      Deprecated version of Disable.
    keymaps = [
      # Markview Markdown sub
      {
        mode = "n";
        key = "<leader>m";
        action = " ";
        options = {
          desc = "Markview-markdown <?>";
        };
      }
      # Markview Hybrid sub
      {
        mode = "n";
        key = "<leader>mh";
        action = " ";
        options = {
          desc = "Hybrid <?>";
        };
      }
      # Markview Buffer sub
      {
        mode = "n";
        key = "<leader>mb";
        action = " ";
        options = {
          desc = "Buffer <?>";
        };
      }
      # Markview Linewise sub
      {
        mode = "n";
        key = "<leader>ml";
        action = " ";
        options = {
          desc = "Linewise Hybrid <?>";
        };
      }
      # Markview Split sub
      {
        mode = "n";
        key = "<leader>ms";
        action = " ";
        options = {
          desc = "Split <?>";
        };
      }
      # Markview Trace sub
      {
        mode = "n";
        key = "<leader>mt";
        action = " ";
        options = {
          desc = "Trace <?>";
        };
      }
      # Start 	        -mS    Allows attaching to new buffers.
      {
        mode = "n";
        key = "<leader>mS";
        action = "<cmd>Markview Start<cr>";
        options = {
          desc = "Allows attaching to new buffers.";
        };
      }
      # Stop 	          -mp    Prevents attaching to new buffers.
      {
        mode = "n";
        key = "<leader>mp";
        action = "<cmd>Markview Stop<cr>";
        options = {
          desc = "Prevents attaching to new buffers.";
        };
      }
      # Enable 	        -me    Enables preview globally.
      {
        mode = "n";
        key = "<leader>me";
        action = "<cmd>Markview Enable<cr>";
        options = {
          desc = "Enables preview globally.";
        };
      }
      # Disable         -md    Disables preview globally.
      {
        mode = "n";
        key = "<leader>md";
        action = "<cmd>Markview Disable<cr>";
        options = {
          desc = "Disables preview globally.";
        };
      }
      # Toggle 	        -mT    Toggles preview globally.
      {
        mode = "n";
        key = "<leader>mT";
        action = "<cmd>Markview Toggle<cr>";
        options = {
          desc = "Toggles preview globally.";
        };
      }
      # Render 	        -mr    Updates preview of all active buffers.
      {
        mode = "n";
        key = "<leader>mr";
        action = "<cmd>Markview Render<cr>";
        options = {
          desc = "Updates preview of all active buffers.";
        };
      }
      # Clear 	        -mc    Clears preview of all active buffer.
      {
        mode = "n";
        key = "<leader>mc";
        action = "<cmd>Markview Clear<cr>";
        options = {
          desc = "Clears preview of all active buffer.";
        };
      }
      # HybridEnable 	  -mhE   Enables hybrid mode.
      {
        mode = "n";
        key = "<leader>mhE";
        action = "<cmd>Markview HybridEnable<cr>";
        options = {
          desc = "Enables hybrid mode.";
        };
      }
      # HybridDisable 	-mhD   Disables hybrid mode.
      {
        mode = "n";
        key = "<leader>mhD";
        action = "<cmd>Markview HybridDisable<cr>";
        options = {
          desc = "Disables hybrid mode.";
        };
      }
      # HybridToggle 	  -mhT   Toggles hybrid mode.
      {
        mode = "n";
        key = "<leader>mhT";
        action = "<cmd>Markview HybridToggle<cr>";
        options = {
          desc = "Toggles hybrid mode.";
        };
      }
      # hybridEnable 	  -mhe   Enables hybrid mode for buffer.
      {
        mode = "n";
        key = "<leader>mhe";
        action = "<cmd>Markview hybridEnable<cr>";
        options = {
          desc = "Enables hybrid mode for buffer.";
        };
      }
      # hybridDisable 	-mhd   Disables hybrid mode for buffer.
      {
        mode = "n";
        key = "<leader>mhd";
        action = "<cmd>Markview hybridDisable<cr>";
        options = {
          desc = "Disables hybrid mode for buffer.";
        };
      }
      # hybridToggle 	  -mht   Toggles hybrid mode for buffer.
      {
        mode = "n";
        key = "<leader>mht";
        action = "<cmd>Markview hybridToggle<cr>";
        options = {
          desc = "Toggles hybrid mode for buffer.";
        };
      }
      # enable 	        -mbe   Enables preview for buffer.
      {
        mode = "n";
        key = "<leader>mbe";
        action = "<cmd>Markview enable<cr>";
        options = {
          desc = "Enables preview for buffer.";
        };
      }
      # disable 	      -mbl   Disables preview for buffer.
      {
        mode = "n";
        key = "<leader>mbl";
        action = "<cmd>Markview disable<cr>";
        options = {
          desc = "Disables preview for buffer.";
        };
      }
      # toggle 	        -mbt   Toggles preview for buffer.
      {
        mode = "n";
        key = "<leader>mbt";
        action = "<cmd>Markview toggle<cr>";
        options = {
          desc = "Toggles preview for buffer.";
        };
      }
      # attach 	        -mba   Attaches to buffer.
      {
        mode = "n";
        key = "<leader>mba";
        action = "<cmd>Markview attach<cr>";
        options = {
          desc = "Attaches to buffer.";
        };
      }
      # detach 	        -mbd   Detaches from buffer.
      {
        mode = "n";
        key = "<leader>mbd";
        action = "<cmd>Markview detach<cr>";
        options = {
          desc = "Detaches from buffer.";
        };
      }
      # render 	        -mbr   Renders preview for buffer.
      {
        mode = "n";
        key = "<leader>mbr";
        action = "<cmd>Markview render<cr>";
        options = {
          desc = "Renders preview for buffer.";
        };
      }
      # clear 	        -mbc   Clears preview for buffer.
      {
        mode = "n";
        key = "<leader>mbc";
        action = "<cmd>Markview clear<cr>";
        options = {
          desc = "Clears preview for buffer.";
        };
      }
      # linewiseEnable 	-mle   Enables linewise hybrid mode.
      {
        mode = "n";
        key = "<leader>mle";
        action = "<cmd>Markview linewiseEnable<cr>";
        options = {
          desc = "Enables linewise hybrid mode.";
        };
      }
      # linewiseDisable -mld   Disables linewise hybrid mode.
      {
        mode = "n";
        key = "<leader>mld";
        action = "<cmd>Markview linewiseDisable<cr>";
        options = {
          desc = "Disables linewise hybrid mode.";
        };
      }
      # linewiseToggle 	-mlt   Toggles linewise hybrid mode.
      {
        mode = "n";
        key = "<leader>mlt";
        action = "<cmd>Markview linewiseToggle<cr>";
        options = {
          desc = "Toggles linewise hybrid mode.";
        };
      }
      # splitOpen 	    -mso   Opens splitview for buffer.
      {
        mode = "n";
        key = "<leader>mso";
        action = "<cmd>Markview splitOpen<cr>";
        options = {
          desc = "Opens splitview for buffer.";
        };
      }
      # splitClose 	    -msc   Closes any open splitview.
      {
        mode = "n";
        key = "<leader>msc";
        action = "<cmd>Markview splitClose<cr>";
        options = {
          desc = "Closes any open splitview.";
        };
      }
      # splitToggle 	  -mst   Toggles splitview.
      {
        mode = "n";
        key = "<leader>mst";
        action = "<cmd>Markview splitToggle<cr>";
        options = {
          desc = "Toggles splitview.";
        };
      }
      # splitRedraw 	  -msr   Updates splitview contents.
      {
        mode = "n";
        key = "<leader>msr";
        action = "<cmd>Markview splitRedraw<cr>";
        options = {
          desc = "Updates splitview contents.";
        };
      }
      # traceExport     -mte    Exports trace logs to trace.txt.
      {
        mode = "n";
        key = "<leader>mte";
        action = "<cmd>Markview traceExport<cr>";
        options = {
          desc = "Exports trace logs to trace.txt.";
        };
      }
      # traceShow 	    -mts    Shows trace logs in a window.
      {
        mode = "n";
        key = "<leader>mts";
        action = "<cmd>Markview traceShow<cr>";
        options = {
          desc = "Shows trace logs in a window.";
        };
      }
    ];
  };
}
#SED_WORK

