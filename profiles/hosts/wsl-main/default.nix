{  pkgs , lib , ... }:

{

  networking.hostName = "wsl-main";

  system.stateVersion = "23.11";

  networking.firewall.allowedTCPPorts = [ 22 ];

  imports = [
    #./emacs.nix  ## On Windows use vscode-win instead
    ./containers.nix
  ];

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry
    pinentry-curses
    colmena
    sops
    #FIXME temporaily lsp support
    nil
    ripgrep
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.direnv = {
    enable = true;
  };
}

