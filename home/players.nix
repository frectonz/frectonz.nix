{ pkgs
, config
, lib
, ...
}: {
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
  };

  home.packages = with pkgs; [ vlc playerctl ];

  services.playerctld = {
    enable = true;
  };
}
