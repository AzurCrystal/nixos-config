{ ... }:

{
  config.sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "users/azurcrystal/passwd" = { };
      "users/builder/key" = { };
      "hosts/wsl-main/ipAddr" = { };
      "hosts/lxc-kabu/ipAddr" = { };
      "hosts/lxc-kabu/ipPort" = { };
      "hosts/kvm-aliyun/ipAddr" = { };
      "hosts/kvm-us-1/ipAddr" = { };
      "hosts/lxc-router/ipAddr" = { };
    };
  };
}
