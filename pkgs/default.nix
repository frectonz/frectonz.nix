{ pkgs }: {
  w = pkgs.writeShellScriptBin "w" ''
    cd $(find ~/workspace -maxdepth 1 -type d | ${pkgs.fzf}/bin/fzf)
  '';
}
