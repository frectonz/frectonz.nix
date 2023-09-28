{ pkgs, ... }: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [ nil brave ];

  programs.chromium = {
    enable = true;
  };

  home = {
    sessionVariables = {
      BROWSER = "brave";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "brave.desktop" ];
    "text/xml" = [ "brave.desktop" ];
    "x-scheme-handler/http" = [ "brave.desktop" ];
    "x-scheme-handler/https" = [ "brave.desktop" ];
  };
}
