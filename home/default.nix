{ pkgs, ... }:

{
  imports = [
    ./base
    ./wayland/sway
    ./programs
  ];

  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      netease-cloud-music-gtk
      qq
      telegram-desktop
      zoxide
      element-desktop
      networkd-notify
    ];
  };
  services = {
    syncthing = {
      enable = true;
      extraOptions = [
        "--no-default-folder"
      ];
    };
    dunst = {
      enable = true;
    };
  };
}
