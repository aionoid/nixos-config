{
  description = "My System flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    #nixpkgs-un.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:dc-tec/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      #url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      #host
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs nixvim;};

        modules = [
          #{ _module.args = inputs; }
          ./configuration.nix
          ./theme.nix

          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ovo = import ./home.nix;
          }
        ];
      };
    };
    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
