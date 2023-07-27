{ pkgs, lib, config, ... }:
{
  # Starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format =
        let
	  git = "($git_branch)($git_commit)($git_state)($git_status)";
        in
        ''
          $username$hostname($cmd_duration)($nix_shell)$custom
          $directory${git}
          $jobs$character
        '';

      # Core
      username = {
        format = "[$user]($style)";
        show_always = true;
      };

      hostname = {
        format = "[@$hostname]($style) ";
        ssh_only = false;
        style = "bold green";
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
      };

      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style)) ";
      };

      nix_shell = {
        format = "[($name \\(develop\\) <- )$symbol]($style) ";
        impure_msg = "";
        symbol = " ";
        style = "bold green";
      };

      custom = {
        nix_inspect = let
          excluded = [ "user-environment" "binutils-wrapper" "pciutils" ];
        in {
          disabled = false;
          when = "test -z $IN_NIX_SHELL";
          command = "${(lib.getExe pkgs.nix-inspect)} ${(lib.concatStringsSep " " excluded)}";
          format = "[($output <- $symbol)]($style) ";
          symbol = " ";
          style = "bold blue";
        };
      };
    };
  };
}
