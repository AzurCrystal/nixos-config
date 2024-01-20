{ ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "acme@azurcrystal.com";
    };
  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
}
