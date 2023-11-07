{ inputs
, pkgs
, ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard

    mako
    libnotify

    swww
    wofi
    xdg-utils
    dmenu-wayland
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  programs.light.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

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
}
