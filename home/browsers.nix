{ pkgs, ... }: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [ speechd ];

  programs.chromium = {
    enable = true;
  };

  home = {
    sessionVariables = {
      BROWSER = "firefox";
      DEFAULT_BROWSER = "firefox";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
  };
}
