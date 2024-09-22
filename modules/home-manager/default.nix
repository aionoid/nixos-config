# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{inputs, ...}: {
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.gBar.homeManagerModules.x86_64-linux.default
    ../theme.nix
    ./gbar.nix
    ./hyprland.nix
    ./waybar.nix
    ./mako.nix
  ];
}
