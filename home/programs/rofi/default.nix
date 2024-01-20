{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  xdg.configFile."rofi" = {
    enable = true;
    recursive = true;
    source = ./config;
  };
}
