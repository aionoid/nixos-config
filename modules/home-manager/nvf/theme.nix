{
  config,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    theme = {
      enable = true;
      #FIXME: set base16 them for following system stylix
      # name = lib.mkForce "base16";
      # base16-colors = with config.lib.stylix.colors; {
      #   inherit base00; # "#1d2021";
      #   inherit base01; # "#3c3836";
      #   inherit base02; # "#504945";
      #   inherit base03; # "#665c54";
      #   inherit base04; # "#bdae93";
      #   inherit base05; # "#d5c4a1";
      #   inherit base06; # "#ebdbb2";
      #   inherit base07; # "#fbf1c7";
      #   inherit base08; # "#fb4934";
      #   inherit base09; # "#fe8019";
      #   inherit base0A; # "#fabd2f";
      #   inherit base0B; # "#b8bb26";
      #   inherit base0C; # "#8ec07c";
      #   inherit base0D; # "#83a598";
      #   inherit base0E; # "#d3869b";
      #   inherit base0F; # "#d65d0e";
      # };
      name = lib.mkForce "gruvbox";
      style = "dark";
      # name = lib.mkForce "catppuccin";
      # style = "mocha";
      transparent = false;
    };
  };
}
