{ pkgs, lib, config, ... }:
{
  programs.zathura = {
    enable = true;
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "application/epub+zip" = "org.pwmt.zathura.desktop";
    "application/postscript" = "org.pwmt.zathura.desktop";
    "application/vnd.comicbook-rar" = "org.pwmt.zathura.desktop";
  };
}
