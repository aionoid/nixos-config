{...}: {
  programs.nvf = {
    settings.vim = {
      assistant = {
        mcphub-nvim = {
          enable = true;
          setupOpts = {
          };
        };
      };
    };
  };
}
