{ pkgs, ... }:
{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 30;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
  };
}
