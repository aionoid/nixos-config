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

    hyperland.url = "github:hyprwm/Hyprland";

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
          ./hosts/home/configuration.nix
          #./theme.nix
          ./nixosModules

          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            specialArgs = {inherit inputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ovo = import ./home.nix;
            home-manager.users.modules = [
              inputs.self.outputs.homeModules.default
            ];
          }
        ];
      };

      work = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs nixvim;};

        modules = [
          #{ _module.args = inputs; }
          ./hosts/work/configuration.nix
          #./theme.nix
          ./nixosModules

          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            specialArgs = {inherit inputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.antiroot = import ./home.nix;
            home-manager.home = {
              home.homeDirectory = "/home/antiroot";
              home.username = "antiroot";
            };
            home-manager.users.modules = [
              inputs.self.outputs.homeModules.default
            ];
          }
        ];
      };
    };
    homeModules.default = ./homeModules;
  };
}
