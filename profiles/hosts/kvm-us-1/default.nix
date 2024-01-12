{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";
  networking.hostName = "kvm-us-1";

  networking = {
    useDHCP = false;
    useNetworkd = true;
  };

  services = {
    resolved = {
      enable = true;
    };
  };

  systemd = {
    network = {
      networks = {
        ens17 = {
          matchConfig = {
            Name = "ens17";
          };
          networkConfig = {
            Address = "10.1.128.2/24";
            Gateway = "10.1.128.1";
            DNS = "8.8.8.8";
          };
        };
      };
    };
  };
}
