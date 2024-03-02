{ config, pkgs, lib, ... }:

{
  system.stateVersion = "23.11"; # Did you read the comment?

  networking.hostName = "kh-laptop"; # Define your hostname.

  nix = {
    settings = {
      substituters = [
	"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
    };
  };

  imports = [
    # specific configuration
    ./hardware.nix
    ./network.nix
    ./power-management.nix

    # modules
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "bcachefs" ];
    kernelParams = [
      "quiet"
      "mitigations=off"
      "nowatchdog"
      "loglevel=3"
    ];
  };

  sops = {
    age.keyFile = "/home/azurcrystal/.config/sops/age/keys.txt";
    secrets = {
      "u2f_keys" = {
        sopsFile = ./.secrets.yaml;
      };
    };
  };

  users.users.azurcrystal.shell = lib.mkForce pkgs.zsh;
  security.pam.u2f.authFile = config.sops.secrets."u2f_keys".path;
}
