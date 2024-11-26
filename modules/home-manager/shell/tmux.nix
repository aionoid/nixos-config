{
  pkgs,
  config,
  ...
}: {
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
    tmux.enableShellIntegration = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    terminal = "screen-256color";
    sensibleOnTop = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig =
      /*
      tmux
      */
      ''
        #set-option -sa terminal-overrides ",xterm*:Tc"
        set -g allow-passthrough on

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
        extraConfig =
          /*
          tmux
          */
          ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
      }
      #THEME
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig =
          /*
          tmux
          */
          ''

            # set -ogp @thm_bg "#${config.lib.stylix.scheme.base00}"          # base00 base
            # set -ogp @thm_surface_1 "#${config.lib.stylix.scheme.base03}"   # base03 surface1
            # set -ogp @thm_fg "#${config.lib.stylix.scheme.base05}"          # base05 text
            # set -ogp @thm_mauve "#${config.lib.stylix.scheme.base0E}"       # base0E mauve
            # set -ogp @thm_crust "#${config.lib.stylix.scheme.base0F}"       # base -?

            set -Ugq @thm_bg
            set -Ugq @thm_fg
            set -ogq @thm_bg "#${config.lib.stylix.scheme.base08}"
            set -ogq @thm_fg "#${config.lib.stylix.scheme.base08}"

            # Colors
            set -ogq @thm_rosewater "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_flamingo "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_rosewater "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_pink "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_mauve "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_red "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_maroon "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_peach "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_yellow "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_green "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_teal "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_sky "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_sapphire "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_blue "#${config.lib.stylix.scheme.base00}"
            set -ogq @thm_lavender "#${config.lib.stylix.scheme.base00}"

            # Surfaces and overlays
            set -ogq @thm_subtext_1 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_subtext_0 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_overlay_2 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_overlay_1 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_overlay_0 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_surface_2 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_surface_1 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_surface_0 "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_mantle "#${config.lib.stylix.scheme.base03}"
            set -ogq @thm_crust "#${config.lib.stylix.scheme.base03}"


            # set -g @catppuccin_window_status_style "rounded"
            # set -g @catppuccin_window_number_position "right"
            #
            # set -g @catppuccin_window_default_fill "number"
            # set -g @catppuccin_window_default_text "#W"
            #
            # set -g @catppuccin_window_current_fill "number"
            # set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_window_left_separator  " "
            set -g @catppuccin_window_right_separator ""
            set -g @catppuccin_status_left_separator  " "
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_fill "icon"
            set -g @catppuccin_status_connect_separator "no"

            set -g @catppuccin_directory_text "#{pane_current_path}"

            # Run catppuccin plugin manually or through tpm
            # ...

            set -g status-left ""
            set -g  status-right "#{E:@catppuccin_status_directory}"
            set -ag status-right "#{E:@catppuccin_status_user}"
            set -ag status-right "#{E:@catppuccin_status_host}"
            set -ag status-right "#{E:@catppuccin_status_session}"
          '';
      }
      # tmuxPlugins.catppuccin
      # tmuxPlugins.gruvbox
      # tmuxPlugins.onedark-theme
      # tmuxPlugins.rose-pine
      # tmuxPlugins.dracula
      # tmuxPlugins.tokyo-night-tmux
      # tmuxPlugins.power-theme
      {
        plugin = tmuxPlugins.tmux-floax;
        extraConfig = ''
          set -g @floax-bind 'e'
          set -g @floax-bind-menu 'P'
        '';
      }
    ];
  };
}
