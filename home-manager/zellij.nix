{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      pane_frames = false;
    };
  };
}
