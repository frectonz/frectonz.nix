{
  services.gpg-agent.enable = true;
  programs.gpg.enable = true;
  programs.fish.loginShellInit = "gpgconf --launch gpg-agent";
}
