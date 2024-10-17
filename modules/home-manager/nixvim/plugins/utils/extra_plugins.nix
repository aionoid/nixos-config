{...}: {
  programs.nixvim = {pkgs, ...}: {
    plugins.web-devicons.enable = true;
    plugins.nvim-colorizer.enable = true;
    # plugins.mini.enable = true;
    # extraPlugins = with pkgs.vimPlugins; [
    #   nvim-web-devicons
    # ];
  };
}
#SED_WORK

