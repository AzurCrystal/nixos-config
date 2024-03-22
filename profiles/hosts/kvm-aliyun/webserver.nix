{ ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "acme@azurcrystal.com";
    };

    certs."pw.azurcrystal.com" = {
      group = "nginx";
    };

  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    
    virtualHosts."planarally.azurcrystal.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8000";
        proxyWebsockets = true;
      };
    };
  };
}
