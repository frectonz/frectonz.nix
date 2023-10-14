{ pkgs }: {
  workspace = pkgs.writeShellScriptBin "workspace" ''
    find ~/workspace -maxdepth 1 -type d | ${pkgs.fzf}/bin/fzf
  '';
}
