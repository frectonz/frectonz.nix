{ pkgs, config, lib, ... }:
{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/password-store";
      PASSWORD_STORE_KEY = "9CFA458945B7094F";
    };
  };

  services.pass-secret-service = {
    enable = true;
    storePath = "${config.home.homeDirectory}/password-store";
    # extraArgs = [ "-e ${config.programs.password-store.package}/bin/pass" ];
  };
}
