{ config, ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      font = "Fira Code 12";
    };
  };
}
