{  pkgs , lib , ... }:

{

  networking.hostName = "azur-main";

  system.stateVersion = "23.05"; 

  networking.firewall.allowedTCPPorts = [ 22 ];

  imports = [
    ./emacs.nix
  ];
}

