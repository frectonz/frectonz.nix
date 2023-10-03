{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./gh.nix
    ./gpg.nix
    ./git.nix
    ./pass.nix
    ./fish.nix
    ./helix.nix
    ./zathura.nix
    ./starship.nix

    ./games.nix
    ./players.nix
    ./browsers.nix
    ./terminals.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "frectonz";
    homeDirectory = "/home/frectonz";
    packages = with pkgs; [
      bottom
      ranger
      obsidian
      neofetch
      processing
      libreoffice
      cool-retro-term
      transmission-gtk
      telegram-desktop
      inputs.mekuteriya.packages.${pkgs.system}.bin
    ];
  };
  programs.htop.enable = true;

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
