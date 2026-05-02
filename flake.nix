{
  description = "frectonz's nix config";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.stable.url = "github:nixos/nixpkgs/nixos-25.11";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.penny.url = "github:frectonz/penny";
  inputs.penny.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nix-index-database.url = "github:nix-community/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  inputs.blueprint.url = "github:numtide/blueprint";
  inputs.blueprint.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
      ];
    };
}
