# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{inputs, ...}: {
  # List your module files here
  # my-module = import ./my-module.nix;
  import = [inputs.stylix.nixosModules.stylix];
  theme = import ./theme.nix;
}
