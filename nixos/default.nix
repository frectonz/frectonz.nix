{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./sound.nix
    ./hardware.nix

    # ./i3.nix
    # ./nvidia.nix
    ./hyprland.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];

  networking.hostName = "newton";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Africa/Addis_Ababa";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users = {
    frectonz = {
      isNormalUser = true;
      shell = pkgs.fish;
      description = "frectonz";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "wireshark" "docker" "libvirtd" ];
    };
  };

  programs.fish.enable = true;
  programs.light.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = [ ];
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" ]; })

      inputs.monaspace.packages.${pkgs.system}.default

      inputs.senamirmir.packages.${pkgs.system}.Senamirmir
      inputs.senamirmir.packages.${pkgs.system}.LeTewahedo
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code Nerd Font" ];
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
