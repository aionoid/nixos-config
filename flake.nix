{
  description = "MY nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-containers.url = "github:nixos/nixpkgs/nixos-24.05";
    # obsidian-nvim.url = "github:epwalsh/obsidian.nvim";
    nvf = {
      url = "github:notashelf/nvf";
      # url = "github:aionoid/nvf-avante-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.obsidian-nvim.follows = "obsidian-nvim";
    };

    # Flake Utils
    flake-utils.url = "github:numtide/flake-utils";
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
      inputs.hyprland.follows = "hyprland";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # Common configuration for all systems
    commonPkgsConfig = {
      allowUnfree = true;
    };

    # Common configuration for all systems
    homePkgsConfig =
      commonPkgsConfig
      // {
        cudaSupport = true;
      };

    # Python overlay (moved to a separate variable for clarity) FIX for onnxruntime
    # TODO: use "https://github.com/NixOS/nixpkgs/pull/382920"
    pythonOverlay = final: prev: {
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (python-final: python-prev: {
            # onnxruntime = python-prev.onnxruntime.overridePythonAttrs (oldAttrs: {
            #   buildInputs = lib.lists.remove final.onnxruntime oldAttrs.buildInputs;
            # });
            rapidocr-onnxruntime = python-prev.rapidocr-onnxruntime.overridePythonAttrs (oldAttrs: {
              disabledTests =
                [
                  # Needs Internet access
                  "test_long_img"
                ]
                ++ lib.optionals python-prev.onnxruntime.cudaSupport [
                  # segfault when built with cuda support but GPU is not availaible in build environment
                  "test_ort_cuda_warning"
                  "test_ort_dml_warning"
                ];
            });
          })
        ];
    };

    #TODO: refactore this >>
    # Base package import function
    basePkgs = system:
      import nixpkgs {
        inherit system;
        config = commonPkgsConfig;
      };

    # System-specific package sets
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        # overlays = [pythonOverlay]; # FIX onnxruntime error for cuda
        overlays = [];
        config = commonPkgsConfig;
      };
    #<< to this

    # Home-specific package set with the overlay
    homePkgs = pkgsFor "x86_64-linux"; # Adjust system as needed
  in {
    packages = lib.genAttrs systems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos {inherit inputs;};
    homeManagerModules = import ./modules/home-manager {inherit inputs;};
    # Add empty homeManagerModules if ./modules/home-manager doesn't exist
    # homeManagerModules =
    #   if builtins.pathExists ./modules/home-manager
    #   then import ./modules/home-manager {inherit inputs;}
    #   else {};
    # homeManagerModules = {
    #   imports = [./modules/home-manager];
    #   _module.args = {inherit inputs outputs;};
    # };

    nixosConfigurations = {
      home = lib.nixosSystem {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            cudaSupport = true;
            allowUnfree = true;
          };
          overlays = [pythonOverlay];
        };
        modules = [self.nixosModules ./hosts/home ./cachix.nix];
        specialArgs = {
          isHome = true;
          inherit inputs outputs;
        };
      };
      work = lib.nixosSystem {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = commonPkgsConfig;
          overlays = [];
        };
        modules = [self.nixosModules ./hosts/work ./cachix.nix];
        specialArgs = {
          isHome = false;
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      "ovo@home" = lib.homeManagerConfiguration {
        pkgs = homePkgs; # Use the home-specific package set
        modules = [
          ./home-manager/ovo.nix
          ./home-manager/home.nix
          self.homeManagerModules
        ];
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "antiroot@work" = lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux"; # Work system without the overlay
        modules = [
          ./home-manager/antiroot.nix
          ./home-manager/home.nix
          self.homeManagerModules
        ];
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
