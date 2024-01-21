{ ... }:
{
  services.fail2ban = {
    enable = true;
  };

  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
        443 # QUIC
      ];
    };
  };

}
