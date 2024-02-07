{ pkgs , lib, ... }:
{
  environment.systemPackages = with pkgs; [
    iwd
  ];

  systemd.network.networks = {
    wlan0 = {
      matchConfig = {
        Name = "wlan0";
      };
      networkConfig = {
        DHCP = "yes";
      };
    };
    enp0s31f6 = {
      matchConfig = {
        Name = "enp0s31f6";
      };
      networkConfig = {
        DHCP = "yes";
      };
    };
  };

  networking = lib.mkForce {
    wireless.iwd.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      interfaces = {
        wlan0 = {
          allowedTCPPorts = [
            22000 # syncthing
          ];
          allowedUDPPorts = [
            22000 # syncthing
          ];
        };
      };
    };
  };
}
