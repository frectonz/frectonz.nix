{ ... }: {
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

        lsp.display-inlay-hints = true;
        indent-guides.render = true;
      };
      keys.insert = {
        j = { k = "normal_mode"; }; # Maps `jk` to exit insert mode
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
