{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 10;
        y = 10;
      };

      font.size = 10.0;

      font.bold.family = "Fira Code Nerd Font";
      font.italic.family = "Fira Code Nerd Font";
      font.normal.family = "Fira Code Nerd Font";

      # font.bold.family = "Monaspace Neon Var";
      # font.italic.family = "Monaspace Neon Var";
      # font.normal.family = "Monaspace Neon Var";

      # Colors (Ayu Dark)
      colors = {
        # Default colors
        primary = {
          background = "0x000000";
          foreground = "0xe6e1cf";
        };

        # Normal colors
        normal = {
          black = "0x000000";
          red = "0xf34a4a";
          green = "0xbae67e";
          yellow = "0xffee99";
          blue = "0x73d0ff";
          magenta = "0xd4bfff";
          cyan = "0x83CEC6";
          white = "0xf2f2f2";
        };

        # Bright colors
        bright = {
          black = "0x737d87";
          red = "0xff3333";
          green = "0xc2d94c";
          yellow = "0xe7c547";
          blue = "0x59c2ff";
          magenta = "0xb77ee0";
          cyan = "0x5ccfe6";
          white = "0xffffff";
        };
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };
}
