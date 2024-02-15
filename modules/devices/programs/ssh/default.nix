{ config, ... }:

let
  ph = config.sops.placeholder;
  wsl-main_ipAddr = ph."hosts/wsl-main/ipAddr";
  lxc-kabu_ipAddr = ph."hosts/lxc-kabu/ipAddr";
  lxc-kabu_ipPort = ph."hosts/lxc-kabu/ipPort";
  kvm-aliyun_ipAddr = ph."hosts/kvm-aliyun/ipAddr";
  kvm-us-1_ipAddr = ph."hosts/kvm-us-1/ipAddr";
  lxc-router_ipAddr = ph."hosts/lxc-router/ipAddr";
in
{
  config.sops.templates."ssh_config" = {
    content = ''
      Host wsl-main
           HostName ${wsl-main_ipAddr}
           Port     22

      Host lxc-kabu
           HostName ${lxc-kabu_ipAddr}
           Port     ${lxc-kabu_ipPort}

      Host kvm-aliyun
           HostName ${kvm-aliyun_ipAddr}
           Port     22

      Host kvm-us-1
           Hostname ${kvm-us-1_ipAddr}
           Port     22

      Host lxc-router
           HostName ${lxc-router_ipAddr}
           Port     22
    '';
    mode = "0444";
  };

  config.programs.ssh.extraConfig = ''
    Include ${config.sops.templates."ssh_config".path}
  '';

}
