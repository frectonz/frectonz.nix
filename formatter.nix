{ pkgs, ... }:
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
