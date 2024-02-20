{  pkgs , lib , ... }:

{

  networking.hostName = "wsl-main";

  system.stateVersion = "23.05";

  networking.firewall.allowedTCPPorts = [ 22 ];

  imports = [
    ./emacs.nix
  ];

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry
    pinentry-curses
    colmena
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}

