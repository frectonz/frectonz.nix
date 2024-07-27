{ pkgs, ... }: {
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = [
    pkgs.mangohud
    pkgs.lutris
    pkgs.protonup
    pkgs.wineWowPackages.stable
    pkgs.winetricks
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/frectonz/.steam/root/compatibilitytools.d";
  };
}
