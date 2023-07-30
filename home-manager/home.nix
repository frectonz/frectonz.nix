{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./fish.nix
    ./pass.nix
    ./starship.nix

    ./mpv.nix
    ./wezterm.nix
    ./alacritty.nix
    ./zathura.nix
    ./discord.nix
    ./chromium.nix

    ./hyprland
    ./helix.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "frectonz";
    homeDirectory = "/home/frectonz";
    packages = with pkgs; [
      # CLI
      bat
      cowsay
      fortune
      lolcat
      ranger
      lazygit

      # GUI
      obsidian
      telegram-desktop

      networkmanagerapplet
    ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      TERMINAL = "alacritty";
    };
  };

  programs.lsd.enable = true;
  programs.vscode.enable = true;

  # Bluetooth
  services.blueman-applet.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;

  # To Fix `command-not-found` for fish
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
