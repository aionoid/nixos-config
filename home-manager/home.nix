# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  outputs,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../apps/graphical
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  xdg.userDirs.enable = true;

  home.packages = with pkgs; [
    fastfetch
    # bat
    # lsd
    vlc
    # nodePackages.gitmoji-cli
    # gotop
    # htop
    qbittorrent
  ];

  # enable programs
  # TODO: move to own nix file for config
  programs.kitty.enable = true;
  programs.bat.enable = true;
  programs.lsd.enable = true;

  xsession.enable = true;
  xsession.numlock.enable = true;

  home.shellAliases = {
    l = "lsd -l";
    ll = "lsd -la";
    lt = "lsd -l --tree";
    t = "lsd --tree";
    llt = "lsd -la --tree";
    cat = "bat";
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    terminal = "screen-256color";
    sensibleOnTop = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      #set-option -sa terminal-overrides ",xterm*:Tc"

      # -- navigation ----------------------------------------------------------------

      # create session
      bind C-c new-session

      # find session
      bind C-f command-prompt -p find-session 'switch-client -t %%'

      # session navigation
      bind BTab switch-client -l  # move to last session

      # split current window horizontally
      bind - split-window -v
      # split current window vertically
      bind _ split-window -h

      # pane navigation
      bind -r h select-pane -L  # move left
      bind -r j select-pane -D  # move down
      bind -r k select-pane -U  # move up
      bind -r l select-pane -R  # move right
      bind > swap-pane -D       # swap current pane with the next one
      bind < swap-pane -U       # swap current pane with the previous one


      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      # window navigation
      unbind n
      unbind p
      bind -r C-h previous-window # select previous window
      bind -r C-l next-window     # select next window
      bind Tab last-window        # move to last active window

      # -- copy mode -----------------------------------------------------------------

      bind Enter copy-mode # enter copy mode

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line

      # -- buffers -------------------------------------------------------------------

      bind b list-buffers     # list paste buffers
      bind p paste-buffer -p  # paste from the top paste buffer
      bind P choose-buffer    # choose which buffer to paste from

      # -- open panes in current dir -------------------------------------------------
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';

    plugins = with pkgs; [
      tmuxPlugins.yank
      # tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      #THEME
      tmuxPlugins.catppuccin
    ];
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ~/.p10k.zsh
      prompt_nix_shell_setup
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
        "vi-mode"
      ];
    };
    history = {
      ignoreDups = true;
      ignorePatterns = [
        "rm *"
        "kill *"
        "cat *"
        "ll *"
      ];
    };
    # syntaxHighlighting = {
    #   enable = true;
    #   package = pkgs.zsh-f-sy-h;
    # };
    #TODO: user zsh-f-sy-h
    #TODO: Change zplug ?
    zplug = {
      enable = true;
      plugins = [
        #{name = "marlonrichert/zsh-autocomplete";} # Simple plugin installation
        {name = "zsh-users/zsh-autosuggestions";} # Simple plugin installation
        {name = "zdharma-continuum/fast-syntax-highlighting";}
        {name = "chisui/zsh-nix-shell";} # Simple plugin installation
        {name = "nix-community/nix-zsh-completions";} # Simple plugin installation
        {
          #TODO: use only one manager ?? use oh-my-posh
          name = "romkatv/powerlevel10k";
          tags = [as:theme depth:1];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    shellAliases = {
      l = "lsd -l";
      ll = "lsd -la";
      lt = "lsd -l --tree";
      t = "lsd --tree";
      llt = "lsd -la --tree";
      cat = "bat";
    };
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
    tmux.enableShellIntegration = true;
  };

  #TODO: move mpd and mpc,ncmcpp to own nix file
  programs.ncmpcpp.enable = true;
  # run 'mpc update' after adding files to
  # ~/Music the default location
  services.mpd = {
    enable = true;
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    network.startWhenNeeded = true;
  };

  #TODO: move to theme folder
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    # QT_STYLE_OVERRIDE = "adwaita-dark";
    # QT_STYLE_OVERRIDE = "adwaita";

    EDITOR = "nvim";

    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
    # SDL_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };

  programs.git = {
    enable = true;
    userName = "Farouk Brown";
    userEmail = "aionoid.xd@gmail.com";
  };

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
