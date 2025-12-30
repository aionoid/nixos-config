{...}: {
  services.wpaperd = {
    enable = true;
    settings = {
      "re:DP-\\d" = {
        path = "~/Pictures/wallpaper";
        # path = "~/Pictures/gif";
        duration = "5m";
      };
      "re:HDMI" = {
        path = "~/Pictures/wallpaper";
        sorting = "descending";
        duration = "5m";
      };
    };
  };
}
