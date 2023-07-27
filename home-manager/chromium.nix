{ pkgs, lib, inputs, ... }:

{
  programs.chromium = {
    enable = true;
  };

  home = {
    sessionVariables = {
      BROWSER = "chromium";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "chromium.desktop" ];
    "text/xml" = [ "chromium.desktop" ];
    "x-scheme-handler/http" = [ "chromium.desktop" ];
    "x-scheme-handler/https" = [ "chromium.desktop" ];
  };
}
