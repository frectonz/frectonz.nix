{
  description = "frectonz's nix config";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprland-contrib = {
    #   url = "github:hyprwm/contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    flake-utils.url = "github:numtide/flake-utils";

    mekuteriya = {
      url = "github:frectonz/mek-ut-er-ya";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

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

    senamirmir = {
      url = "github:frectonz/senamirmir-nixified";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fu.follows = "flake-utils";
    };

    lessonalyzer = {
      url = "github:frectonz/lessonalyzer";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
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
