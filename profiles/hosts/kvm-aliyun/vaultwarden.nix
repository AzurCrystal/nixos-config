{ config, ... }:

/* pw.azurcrystal.com
 * Bitwarden Service
 */

{
  config.services = {
    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      environmentFile = config.sops.secrets.vaultwardenEnv.path;
    };


    nginx.virtualHosts."pw.azurcrystal.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8080";
        proxyWebsockets = true;
      };
    };
  };

  config.security.acme.certs."pw.azurcrystal.com" = {
    group = "nginx";
  };

  config.sops.secrets = {
    vaultwardenEnv = {
      sopsFile = ./secrets.yaml;
      owner = "vaultwarden";
      group = "vaultwarden";
      mode = "0440";
    };
  };
}
