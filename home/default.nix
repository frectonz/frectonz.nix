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
    ./mpv.nix
    ./pass.nix
    ./fish.nix
    ./helix.nix
    ./browser.nix
    ./starship.nix
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
      obsidian
      telegram-desktop
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
