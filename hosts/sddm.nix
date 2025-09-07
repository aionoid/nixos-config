{...}: {
  services.displayManager.sddm = {
    autoNumlock = true;
    wayland.enable = true;
    enable = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        # Background = lib.cleanSource ./background.png;
        # ScreenWidth = 1920;
        # ScreenHeight = 1080;
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
      };
    };
  };
}
