{
  pkgs,
  inputs,
  ...
}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
          _ps=(waybar mako)
          for _prs in "$\{_ps[@]}"; do
            if [[ `pidof $\{_prs}` ]]; then
              killall -9 $\{_prs}
            fi
          done

    # Apply themes
    # ~/.config/hypr/scripts/gtkthemes &

    # Lauch notification daemon (mako)
    #~/.config/hypr/scripts/notifications &

    # Lauch statusbar (waybar)
    # ~/.config/hypr/scripts/statusbar &

    # Start network manager applet
    # $\{pkgs.gbar}/bin/gbar &
    ${pkgs.swww}/bin/swww-daemon &
    nm-applet

    sleep 1
  '';
in {
  home.packages = with pkgs; [
    # hyprpanel
    networkmanagerapplet
    swww
    libnotify
    xdg-user-dirs
  ];
  wayland.windowManager.hyprland.settings = {
    #-- Startup ----------------------------------------------------
    # exec-once = ["~/.config/hypr/scripts/startup"];
    exec-once = [
      # ''${startupScript}/bin/start''
      "swww-daemon"
      "nm-applet"
    ];
  };
}
