{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "frectonz";
    userEmail = "fraol0912@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      user.signing.key = "9CFA458945B7094F";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
