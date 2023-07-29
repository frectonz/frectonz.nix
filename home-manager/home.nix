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

    ./wezterm.nix
    ./alacritty.nix
    ./zathura.nix
    ./discord.nix
    ./chromium.nix

    ./hyprland
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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
      cowsay
      fortune
      lolcat
      ranger
      bat
      lazygit

      # GUI
      obsidian
      telegram-desktop

      networkmanagerapplet
    ];

    sessionVariables = {
      EDITOR   = "nvim";
      VISUAL   = "nvim";
      TERMINAL = "alacritty";
    };
  };

  programs.lsd.enable = true;
  programs.neovim.enable = true;
  programs.vscode.enable = true;

  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
  };

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