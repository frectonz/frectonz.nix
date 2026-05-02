{ flake, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./home-manager.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./user.nix
    flake.nixosModules.openssh
    flake.nixosModules.penny
    flake.inputs.penny.nixosModules.penny
  ];

  environment.systemPackages = [ pkgs.ghostty.terminfo ];
  programs.command-not-found.enable = false;

  system.stateVersion = "25.11";
  system.configurationRevision = flake.rev or flake.dirtyRev or null;
}
