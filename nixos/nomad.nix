{ pkgs, ... }: {
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 20000;
      to = 32000;
    }
  ];

  services.nomad = {
    enable = true;
    enableDocker = true;
    dropPrivileges = false;
    settings = {
      client.enabled = true;
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
    };
  };

  environment.systemPackages = [ pkgs.damon ];
}
