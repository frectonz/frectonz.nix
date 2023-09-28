{ pkgs, lib, config, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd --group-directories-first -al";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      cat = "bat";
      hm = "home-manger";
      nr = "sudo nixos-rebuild";
    };
    shellAbbrs = {
      lg = "lazygit";
      addall = "git add .";
      branches = "git branch";
      commit = "git commit -m";
      remotes = "git remote";
      clone = "git clone";
      pull = "git pull origin";
      push = "git push origin";
      pushup = "git push -U origin main";
      stat = "git status";
    };
    functions = {
      fish_greeting = "";
    };
  };

  home.packages = with pkgs; [ bat lazygit lsd ];
}
