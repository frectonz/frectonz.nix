{ pkgs, lib, config, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "ayu_evolve";
      editor = {
        mouse = false;
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape.insert = "bar";

        whitespace.render = {
          space = "all";
          tab = "all";
          newline = "none";
        };

        indent-guides.render = true;
      };
    };
  };
}
