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
        # "HDMI-A-1,1920x1080,0x0,1"
        {
          output = "HDMI-A-1";
          mode = "1920x1080";
          position = "0x0";
          scale = 1;
        }
        # :INFO: left monitor
        # "DP-2,1440x900,1920x0,1,transform,1"
        {
          output = "DP-2";
          mode = "1440x900";
          position = "1920x0";
          transform = 1;
          scale = 1;
        }
        # monitor = HDMI-A-1,1920x1080@60,1920x0,1
        # ",preferred,auto,1"
        # {
        #   mode = "preferred";
        #   position = "auto";
        #   scale = 1;
        # }
      ];
    };
  };
}
