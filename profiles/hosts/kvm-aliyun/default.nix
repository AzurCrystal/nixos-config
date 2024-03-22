{  ... }:
{
  imports = [
    ./vaultwarden.nix
    ./hardware-configuration.nix
    ./postgresql.nix
    ./webserver.nix
    ./container.nix
  ];
  networking.hostName = "kh-aliyun-cn";
  system.stateVersion = "24.05";

  nix = {
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
    };
  };

  networking = {
    firewall = {
      enable = false; # Use Aliyun provided firewall
    };
  };
}
