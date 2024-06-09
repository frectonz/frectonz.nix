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

    inputs.nur.hmModules.nur
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
      fd
      feh

      nil
      nixd

      zip
      unzip
      unrar

      devbox

      timer
      ffmpeg
      bottom
      ranger
      neofetch
      libreoffice
      cool-retro-term
      transmission-gtk
      telegram-desktop

      gnome.gnome-disk-utility

      imagemagick

      inputs.tuime.defaultPackage.${pkgs.system}
      inputs.lobste-rs.packages.${pkgs.system}.bin
      inputs.mekuteriya.packages.${pkgs.system}.bin
      inputs.battop.packages.${pkgs.system}.default
      inputs.lithium.packages.${pkgs.system}.default
      inputs.birru_cli.packages.${pkgs.system}.birru
      inputs.watchbox.packages.${pkgs.system}.default
      inputs.license-gen.packages.${pkgs.system}.default
      inputs.murder_tool.packages.${pkgs.system}.default
      inputs.lessonalyzer.packages.${pkgs.system}.default
    ];
  };

  programs.htop.enable = true;
  programs.home-manager.enable = true;
  programs.obs-studio.enable = true;

  xdg.mimeApps.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
