{ flake, pkgs, ... }:
{
  users.users.frectonz = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "frectonz";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keyFiles = [
      "${flake}/users/frectonz/authorized_keys"
    ];
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
