{ ... }:

{
  imports = [
    ./services.nix
  ];
  system.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
    };
  };

  services = {
    resolved = {
      enable = true;
    };
  };

  networking = {
    useDHCP = false;
    useNetworkd = true;
  };

  systemd = {
    network = {
      networks = {
        eth0 = {
          matchConfig = {
            Name = "eth0";
          };
          networkConfig = {
            Address = "10.127.0.251/24";
            Gateway = "10.127.0.253";
            DNS = "10.127.0.253";
          };
        };
      };
    };
  };

  networking = {
    hostName = "router-lxc";
    useHostResolvConf = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        7892 # AutoBangumi
        8080 # QBittorrent
        8123 # HAOS
      ];
      allowedUDPPorts = [

      ];
    };
  };
}
