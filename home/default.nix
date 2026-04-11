{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    ./gh.nix
    ./gpg.nix
    ./git.nix
    ./nvim.nix
    ./pass.nix
    ./fish.nix
    ./helix.nix
    ./starship.nix

    inputs.nur.modules.homeManager.default
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
      zip
      nixd
      dive
      unzip
      unrar
      devenv
      ffmpeg
      bottom
      ranger
      neofetch
      mekuteriya
      imagemagick

      inputs.tuime.defaultPackage.${pkgs.system}
      inputs.lobste-rs.packages.${pkgs.system}.bin
      inputs.watchbox.packages.${pkgs.system}.default
      inputs.license-gen.packages.${pkgs.system}.default
      inputs.murder_tool.packages.${pkgs.system}.default
      inputs.lessonalyzer.packages.${pkgs.system}.default
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
