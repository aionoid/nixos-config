{
  description = "MY nix config";

  # nixConfig = {
  #   extra-substituters = ["https://hyprland.cachix.org"];
  #   extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  # };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

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

    ags.url = "github:Aylur/ags";
    # matugen.url = "github:InioX/matugen?ref=v2.2.0";
    # nix-gaming.url = "github:fufexan/nix-gaming";
    # microfetch.url = "github:NotAShelf/microfetch";

    # auto ricing
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    #TODO: user nixvim direct config
    # nixvim like lazyvim profile
    nixvim.url = "github:dc-tec/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
    #gBar
    gBar.url = "github:scorpion-26/gBar";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # lib = nixpkgs.lib // home-manager.lib;
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
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
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
      # FIXME replace with your hostname
      # your-hostname = nixpkgs.lib.nixosSystem {
      # # Main desktop
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [
      #     # > Our main nixos configuration file <
      #     ./nixos/configuration.nix
      #   ];
      #   };
      home = nixpkgs.lib.nixosSystem {
        modules = [self.nixosModules ./hosts/home ./cachix.nix];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      # Secondary desktop
      work = nixpkgs.lib.nixosSystem {
        modules = [./hosts/work self.nixosModules ./cachix.nix];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      # "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
      #   extraSpecialArgs = {inherit inputs outputs;};
      #   modules = [
      #     # > Our main home-manager configuration file <
      #     ./home-manager/home.nix
      #   ];
      # };

      "ovo@home" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home-manager/ovo.nix
          ./home-manager/home.nix
          self.homeManagerModules
        ];
        # pkgs = pkgsFor.x86_64-linux;
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # Main desktop
      "antiroot@work" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home-manager/antiroot.nix
          ./home-manager/home.nix
          self.homeManagerModules
        ];
        # pkgs = pkgsFor.x86_64-linux;
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
