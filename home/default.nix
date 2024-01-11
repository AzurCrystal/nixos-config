{ pkgs, ... }:

rec {
  systemd.user.sessionVariables = {
    LANG = "zh_CN.UTF-8";
    BROWSER = "firefox";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
    MOZ_WEBRENDER = "1";
  };
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      netease-cloud-music-gtk
      unzip
      unrar
      jq
      fd
      qq
      telegram-desktop
      zinit
      zoxide
      element-desktop
      networkd-notify
    ];
    sessionVariables = systemd.user.sessionVariables;
  };
  imports = [
    ./wayland/sway
    ./programs
  ];
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
