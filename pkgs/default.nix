# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  nix-inspect = pkgs.callPackage ./nix-inspect { };
  pass-wofi = pkgs.callPackage ./pass-wofi { };
}
