{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    nixpkgs-fmt
    dig
    tree
    subversion
    unzip
    unrar
    p7zip
    jq
  ];
}
