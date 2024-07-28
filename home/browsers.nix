{ pkgs, ... }: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [ speechd ];

  programs.chromium = {
    enable = true;
  };

  home = {
    sessionVariables = {
      BROWSER = "chromium";
      DEFAULT_BROWSER = "chromium";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "chromium.desktop";
    "x-scheme-handler/http" = "chromium.desktop";
    "x-scheme-handler/https" = "chromium.desktop";
    "x-scheme-handler/about" = "chromium.desktop";
  };
}
