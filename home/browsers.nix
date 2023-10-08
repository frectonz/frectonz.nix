{ pkgs, ... }: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [ nil brave ];

  programs.chromium = {
    enable = true;
  };

  home = {
    sessionVariables = {
      BROWSER = "firefox";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
