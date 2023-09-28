{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [ superTuxKart ];
}
