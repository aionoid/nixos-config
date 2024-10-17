{...}: {
  programs.nixvim = {
    plugins.schemastore = {
      enable = true;

      json = {
        enable = true;
      };

      yaml = {
        enable = true;
      };
    };
  };
}
#SED_WORK

