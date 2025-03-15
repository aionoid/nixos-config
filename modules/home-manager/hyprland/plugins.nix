{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      # inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
    ];
    #
    settings = {
      plugin = {
        split-monitor-workspaces = {
          count = 10;
        };
        # hyprsplit = {
        #   num_workspaces = 10;
        # };
        borders-plus-plus = {
          count = 2;
          # you can add up to 9 borders
          "col.border_1" = "rgb(ffffff)";
          "col.border_2" = "rgb(2222ff)";

          # -1 means "default" as in the one defined in general:border_size
          border_size_1 = 10;
          border_size_2 = -1;

          # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
          natural_rounding = "yes";
        };
      };
    };
  };
}
