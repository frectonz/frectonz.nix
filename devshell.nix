{ pkgs, ... }:
pkgs.mkShell {
  packages = [
    pkgs.nixos-rebuild
  ];
}
