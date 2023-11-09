{
  description = "frectonz's nix config";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mekuteriya = {
      url = "github:frectonz/mek-ut-er-ya";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tuime = {
      url = "github:nate-sys/tuime";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lobste-rs = {
      url = "github:frectonz/lobste-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lithium = {
      url = "github:frectonz/lithium";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    license-gen = {
      url = "github:frectonz/license-gen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    battop = {
      url = "github:frectonz/rust-battop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    senamirmir = {
      url = "github:frectonz/senamirmir-nixified";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home;

      nixosConfigurations = {
        newton = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos ];
        };
      };

      homeConfigurations = {
        "frectonz@newton" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home ];
        };
      };
    };
}
