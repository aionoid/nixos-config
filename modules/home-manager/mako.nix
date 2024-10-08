{pkgs, ...}: {
  services.mako = {
    enable = true;

    anchor = "top-left";
    borderRadius = 15;
    borderSize = 2;
    # borderColor =
    defaultTimeout = 5000;
    width = 300;
    height = 100;
    # iconPath= ;
    ignoreTimeout = false;
    layer = "overlay";
    margin = "10";
    markup = true;
    maxIconSize = 48;
    maxVisible = 5;
    padding = "15";
    sort = "-time";
    # textColor = "";

    extraConfig = ''
      [urgency=low]
      border-color=#B4A1DB
      default-timeout=2000

      [urgency=normal]
      border-color=#B4A1DB
      default-timeout=5000

      [urgency=high]
      border-color=#D04E9D
      text-color=#D04E9D
      default-timeout=0

      [category=mpd]
      border-color=#E49186
      default-timeout=2000
      group-by=category

    '';
  };
}
