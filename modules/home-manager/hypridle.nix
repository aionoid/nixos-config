{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        # Noctalia v5 lock screen (replaces hyprlock).
        lock_cmd = "noctalia msg session lock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "noctalia msg session lock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
