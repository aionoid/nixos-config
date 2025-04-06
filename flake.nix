{
  description = "MY nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-containers.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # firefox-addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix hardware
    hardware.url = "github:nixos/nixos-hardware";

    # auto ricing
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # lib = nixpkgs.lib // home-manager.lib;
    lib = inputs.nixpkgs.lib // inputs.home-manager.lib;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    system = "x86_64-linux"; # change to whatever your system should be.
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        # inputs.hyprpanel.overlay
      ];
    };
    forAllSystems = lib.genAttrs systems;
    # pkgsFor = lib.genAttrs (import systems) (
    #   system:
    #     import nixpkgs {
    #       inherit system;
    #       config.allowUnfree = true;
    #       overlays = [
    #         # inputs.hyprpanel.overlay
    #       ];
    #     }
    # );
  in {
    # inherit lib;
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # HOME Desktop
      home = lib.nixosSystem {
        modules = [self.nixosModules ./hosts/home ./cachix.nix];
        specialArgs = {
          isHome = true; # to make if statment
          inherit inputs outputs;
        };
      };
      # WORK Desktop
      work = lib.nixosSystem {
        modules = [self.nixosModules ./hosts/work ./cachix.nix];
        specialArgs = {
          isHome = false;
          inherit inputs outputs;
        };
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # HOME Desktop
      "ovo@home" = lib.homeManagerConfiguration {
        modules = [
          ./home-manager/ovo.nix
          ./home-manager/home.nix
          self.homeManagerModules
        ];
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # WORK desktop
      "antiroot@work" = lib.homeManagerConfiguration {
        modules = [
          ./home-manager/antiroot.nix
          ./home-manager/home.nix
          self.homeManagerModules
        ];
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
