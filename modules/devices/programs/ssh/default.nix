{ config, ... }:

let
  wsl-main_ipAddr = config.sops.placeholder."hosts/wsl-main/ipAddr";
  lxc-kabu_ipAddr = config.sops.placeholder."hosts/lxc-kabu/ipAddr";
  lxc-kabu_ipPort = config.sops.placeholder."hosts/lxc-kabu/ipPort";
  kvm-aliyun_ipAddr = config.sops.placeholder."hosts/kvm-aliyun/ipAddr";
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
    '';
    mode = "0444";
  };

  config.programs.ssh.extraConfig = ''
    Include ${config.sops.templates."ssh_config".path}
  '';

}
