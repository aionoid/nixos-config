{...}: {
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
        };
        surround = {};
      };
    };
  };
}
#SED_WORK

