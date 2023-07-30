{ pkgs, config, lib, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
  };
}
