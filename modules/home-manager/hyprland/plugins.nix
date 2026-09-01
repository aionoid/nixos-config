{
  # Hyprland plugins.
  #
  # split-monitor-workspaces: the flake's `packages` output is only the C++ build,
  # which is deprecated upstream ("please use the Lua package instead"). We therefore
  # do NOT load it here; instead the pure-Lua smw package is required and configured
  # in workspace.nix's extraConfig (see the smw bootstrap block there).
  #
  # To load a C++ plugin, add it to `plugins`, e.g.:
  # plugins = [ inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus ];
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [ ];
  };
}
