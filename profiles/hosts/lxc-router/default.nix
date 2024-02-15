{ ... }:

{
  imports = [

  ];
  system.stateVersion = "24.05";

  networking = {
    useDHCP = false;
    useNetworkd = true;
  };

  networking = {
    hostName = "router-lxc";
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
            Address = "10.127.0.251/24";
            Gateway = "10.127.0.253";
            DNS = "10.127.0.253";
          };
        };
      };
    };
  };
}
