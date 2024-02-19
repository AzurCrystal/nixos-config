{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    iwd
  ];

  systemd.network = {
    netdevs = {
      bond0 = {
        netdevConfig = {
          Name = "bond0";
          Kind = "bond";
        };
        bondConfig = {
          Mode = "active-backup";
          PrimaryReselectPolicy = "always";
          MIIMonitorSec = "1s";
        };
      };
    };
    networks = {
      wlan0 = {
        matchConfig = {
          Name = "wlan0";
        };
        networkConfig = {
          Bond = "bond0";
        };
      };
      enp0s31f6 = {
        matchConfig = {
          Name = "enp0s31f6";
        };
        networkConfig = {
          Bond = "bond0";
          PrimarySlave = true;
        };
      };
      bond0 = {
        matchConfig = {
          Name = "bond0";
        };
        networkConfig = {
          BindCarrier = "enp0s31f6 wlan0";
          DHCP = "yes";
        };
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
