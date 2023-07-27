{ config, pkgs, inputs, ... }:

let
in
rec {
  gtk = {
    enable = true;
    font = {
      name = "Fira Code";
      size = 10;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
