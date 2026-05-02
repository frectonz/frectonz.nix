{ pkgs, ... }:
let
  statix-fmt = pkgs.writeShellScript "statix-fmt" ''
    for f in "$@"; do
      ${pkgs.statix}/bin/statix fix -- "$f"
    done
  '';
in
pkgs.treefmt.withConfig {
  runtimeInputs = [
    pkgs.nixfmt
    pkgs.statix
  ];
  settings = {
    on-unmatched = "info";
    formatter.nixfmt = {
      command = "nixfmt";
      includes = [ "*.nix" ];
    };
    formatter.statix = {
      command = statix-fmt;
      includes = [ "*.nix" ];
    };
  };
}
