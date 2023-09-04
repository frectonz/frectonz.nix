{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./gtk.nix
    ./mako.nix
    ./wofi.nix
    ./waybar.nix
    ./playerctl.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${system}.grimblast
    swaybg
    swayidle
    pavucontrol
    pulseaudio
    jq

    wl-clipboard
    # inputs.hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland
  ];

  programs = {
    fish.loginShellInit = ''
      if test (tty) = "/dev/tty1"
        exec Hyprland &> /dev/null
      end
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix;

    # nvidiaPatches = true;
    xwayland.enable = true;
    recommendedEnvironment = true;
  };

  home.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
}
