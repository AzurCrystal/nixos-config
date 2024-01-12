{ ... }:

{

  system.stateVersion = "23.05";

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

  networking = {
    hostName = "kabu-lxc";
    useHostResolvConf = false;
  };

  systemd = {
    network = {
      networks = {
        eth0 = {
          matchConfig = {
            Name = "eth0";
          };
          networkConfig = {
            Address = "10.10.1.30/24";
            Gateway = "10.10.1.254";
            DNS = "223.5.5.5";
          };
        };
      };
    };
  };
}
