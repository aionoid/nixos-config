{...}: {
  imports = [./home.nix];
  # username
  home = {
    username = "ovo";
    homeDirectory = "/home/ovo";
  };

  wayland.windowManager.hyprland = {
    settings = {
      # #-- Output -----------------------------------------------------
      # monitor = ,preferred,auto,1
      # HOME setup
      monitor = [
        # :INFO: right monitor
        # "HDMI-A-1,1600x900,1440x0,1.2"
        "HDMI-A-1,1920x1080,0x0,1"
        # :INFO: left monitor
        "DP-2,1440x900,1920x0,1"
        # monitor = HDMI-A-1,1920x1080@60,1920x0,1
        ",preferred,auto,1"
      ];
    };
  };
}
