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

        specialArgs = { inherit inputs outputs self; };
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
          runtimeInputs = [ pkgs.nixfmt ];

          settings = {
            on-unmatched = "info";
            formatter.nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
            };
          };
        }
      );
    };
}
