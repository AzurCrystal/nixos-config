{ config , pkgs, ... }:

{
  imports = [
    ../../base/programs

    ./ssh
  ];

  environment.systemPackages = with pkgs; [
    age
    ssh-to-age
    sops
    evtest
    colmena
    bat
    just
    fd
    ripgrep
    libva-utils
  ];

  programs = {
    zsh.enable = true;
  };
}
