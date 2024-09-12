{
  inputs,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../modules/nixos/theme.nix

    # inputs.home-manager.nixosModules.home-manager
    # {
    #   home-manager.useGlobalPkgs = true;
    #   home-manager.useUserPackages = true;
    #   # home-manager.users.antiroot = import ./home.nix;
    # }
  ];

  environment.systemPackages = with pkgs; [
    # git
    # inputs.nixvim.packages.x86_64-linux.default
    home-manager
  ];
  # home-manager = {
  #   extraSpecialArgs = {inherit inputs outputs;};
  #   users = {
  #     # Import your home-manager configuration
  #     antiroot = import [../home-manager/home.nix ../home-manager/antiroot.nix];
  #     ovo = import [../home-manager/home.nix ../home-manager/ovo.nix];
  #   };
  # };
}
