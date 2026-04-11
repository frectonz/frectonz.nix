{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./gh.nix
    ./gpg.nix
    ./git.nix
    ./pass.nix
    ./fish.nix
    ./helix.nix
    ./starship.nix
  ];

  home = {
    username = "frectonz";
    homeDirectory = "/home/frectonz";
    packages = with pkgs; [
      fd
      feh
      nil
      zip
      nixd
      dive
      unzip
      unrar
      devenv
      ffmpeg
      bottom
      ranger
      fastfetch
      mekuteriya
      imagemagick
    ];
  };

  programs.htop.enable = true;
  programs.home-manager.enable = true;

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
