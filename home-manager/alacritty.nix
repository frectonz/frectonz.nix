{ pkgs, lib, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 20;
	y = 20;
      };
      font =
        let
          font = "Fira Code Nerd Font";
        in
        {
          normal.family = font;
	  bold.family   = font;
	  italic.family = font;
        };
    };
  };
}
