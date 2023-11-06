{ inputs
, outputs
, pkgs
, ...
}: {
  imports = [
    ./nvim.nix

    ./gtk.nix

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
      vscode

      nil

      zip
      unzip

      timer
      bottom
      ranger
      obsidian
      neofetch
      processing
      libreoffice
      cool-retro-term
      transmission-gtk
      telegram-desktop

      slack
      discord

      inputs.tuime.defaultPackage.${pkgs.system}
      inputs.lobste-rs.packages.${pkgs.system}.bin
      inputs.mekuteriya.packages.${pkgs.system}.bin
      inputs.lithium.packages.${pkgs.system}.default
    ];
  };
  programs.htop.enable = true;
  programs.home-manager.enable = true;

  xdg.mimeApps.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
