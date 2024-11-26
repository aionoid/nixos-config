{pkgs, ...}: {
  # programs.oh-my-posh = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   # useTheme = "atomicBit";
  #   settings = builtins.fromTOML (builtins.readFile ./zen.toml);
  # };
  home.file = {
    ".p10k.zsh" = {
      text = builtins.readFile ./p10k.zsh;
      executable = false;
    };
  };
  programs.zsh = {
    enable = true;
    initExtra =
      /*
      bash
      */
      ''
        source ~/.p10k.zsh
        # prompt_nix_shell_setup
        prompt_nix_shell_setup "$@"
      '';
    plugins = [
      {
        name = "zsh-f-sy-h";
        file = "share/zsh/site-functions/F-Sy-H.plugin.zsh";
        src = pkgs.zsh-f-sy-h;
      }
      # {
      #   name = "colored-man-pages";
      #   file = "share/oh-my-zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh";
      #   src = pkgs.oh-my-zsh;
      # }
      {
        name = "git";
        file = "share/oh-my-zsh/plugins/git/git.plugin.zsh";
        src = pkgs.oh-my-zsh;
      }
      {
        name = "zsh-vi-mode";
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        src = pkgs.zsh-vi-mode;
      }
      {
        name = "zsh-nix-shell";
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        src = pkgs.zsh-nix-shell;
      }
      {
        name = "zsh-clipboard";
        file = "share/zsh/plugins/clipboard/zsh-clipboard.plugin.zsh";
        src = pkgs.zsh-clipboard;
      }
      {
        name = "nix-zsh-completions";
        file = "share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh";
        src = pkgs.nix-zsh-completions;
      }
      {
        name = "zsh-you-should-use";
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
        src = pkgs.zsh-you-should-use;
      }
      {
        name = "zsh-autosuggestions";
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-powerlevel10k";
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        src = pkgs.zsh-powerlevel10k;
      }
    ];
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [
    #     "git"
    #     "colored-man-pages"
    #     "vi-mode"
    #   ];
    # };
    history = {
      ignoreDups = true;
      ignorePatterns = [
        "rm *"
        "kill *"
        "cat *"
        "ll *"
      ];
    };
    # zplug = {
    #   enable = true;
    #   plugins = [
    #     #{name = "marlonrichert/zsh-autocomplete";} # Simple plugin installation
    #     # {name = "zsh-users/zsh-autosuggestions";} # Simple plugin installation
    #     {name = "zdharma-continuum/fast-syntax-highlighting";}
    #     # {name = "chisui/zsh-nix-shell";} # Simple plugin installation
    #     # {name = "nix-community/nix-zsh-completions";} # Simple plugin installation
    #   ];
    # };
    shellAliases = {
      l = "lsd -l";
      ll = "lsd -la";
      lt = "lsd -l --tree";
      t = "lsd --tree";
      llt = "lsd -la --tree";
      cat = "bat";
    };
  };
}
