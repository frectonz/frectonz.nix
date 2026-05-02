{ pkgs, ... }:
pkgs.mkShell {
  packages = [
    pkgs.nh
    pkgs.statix
    pkgs.nixos-rebuild
  ];
}
