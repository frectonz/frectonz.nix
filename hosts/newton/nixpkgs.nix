{ flake, perSystem, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (_final: _prev: { inherit (perSystem.self) workspace; })
    flake.inputs.penny.overlays.default
  ];
}
