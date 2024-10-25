{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./sound.nix
    ./nvidia.nix
    ./hyprland.nix
    ./hardware.nix

    # ./i3.nix
    # ./games.nix
    # ./nomad.nix
    # ./databases.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelModules = [ "v4l2loopback" ];
  #boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "newton";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  time.timeZone = "Africa/Addis_Ababa";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ m17n ];
  };
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
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  virtualisation.docker.enable = true;

  fonts = {
    packages = with pkgs; [
      monaspace
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code Nerd Font" ];
      };
    };
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];

  fileSystems."/home/frectonz/Data" = {
    device = "/dev/disk/by-label/hdd";
    fsType = "btrfs";
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "frectonz";
  };

  programs.command-not-found.enable = false;

  #virtualisation.libvirtd.enable = true;
  #programs.virt-manager.enable = true;

  #virtualisation.vmware.host.enable = true;

  #services.ollama = {
  #  enable = true;
  #  acceleration = "cuda";
  #};

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
