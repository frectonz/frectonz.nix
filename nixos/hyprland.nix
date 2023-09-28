{ inputs
, pkgs
, ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  environment.systemPackages = with pkgs; [ wl-clipboard mako libnotify swww wofi dmenu-wayland ];
  programs.light.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
}