{ pkgs, lib, config, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
