{}: {
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ara";
    options = "grp:lalt_lshift_toggle";
    variant = "";
  };
}
