{
  pkgs,
  ...
}:
{
  services.penny = {
    enable = true;
    package = pkgs.penny;
    settings = {
      api_address = "127.0.0.1:3031";

      "app1.example.com" = {
        address = "127.0.0.1:3001";
        command = "${pkgs.bun}/bin/bun -e \"Bun.serve({ port: 3001, fetch: () => new Response('Hello from app1!') })\"";
        health_check = "/";
        wait_period = "5m";
      };

      "app2.example.com" = {
        address = "127.0.0.1:3002";
        command = "${pkgs.bun}/bin/bun -e \"Bun.serve({ port: 3002, fetch: () => new Response(JSON.stringify({ status: 'ok', app: 'app2' }), { headers: { 'Content-Type': 'application/json' } }) })\"";
        health_check = "/";
        wait_period = "10m";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 3031 ];
}
