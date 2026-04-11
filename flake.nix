{
  description = "frectonz's nix config";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    tuime = {
      url = "github:nate-sys/tuime";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    lobste-rs = {
      url = "github:frectonz/lobste-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    license-gen = {
      url = "github:frectonz/license-gen";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    watchbox = {
      url = "github:frectonz/watchbox";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    murder_tool = {
      url = "github:frectonz/murder_tool";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    lessonalyzer = {
      url = "github:frectonz/lessonalyzer";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
      ];
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home;

      nixosConfigurations.newton = nixpkgs.lib.nixosSystem {

        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [
            outputs.overlays.additions
            outputs.overlays.modifications
            outputs.overlays.unstable-packages
            inputs.nur.overlays.default
          ];
          config = {
            allowUnfree = true;
          };
        };

        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.sharedModules = [ ];
            home-manager.extraSpecialArgs = { inherit inputs outputs; };

            home-manager.useGlobalPkgs = true;
            home-manager.users.frectonz = import ./home;
            home-manager.backupCommand = "echo";
          }
        ];
      };

      formatter = forEachSystem (
        pkgs:
        pkgs.treefmt.withConfig {
          runtimeInputs = [ pkgs.nixfmt-rfc-style ];

          settings = {
            # Log level for files treefmt won't format
            on-unmatched = "info";

            # Configure nixfmt for .nix files
            formatter.nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
            };
          };
        }
      );
    };
}
