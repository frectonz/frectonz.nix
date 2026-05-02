{
  config,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "frectonz";
      user.email = "fraol0912@gmail.com";
      init.defaultBranch = "main";
      user.signing.key = "9CFA458945B7094F";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
