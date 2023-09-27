{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hardware.url = "github:nixos/nixos-hardware";
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        newton = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "frectonz@newton" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            hyprland.homeManagerModules.default
            ./home-manager/home.nix
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
