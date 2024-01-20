{ ... }:
rec {
  systemd.user.sessionVariables = {
    LANG = "zh_CN.UTF-8";
    BROWSER = "firefox";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
    MOZ_WEBRENDER = "1";
  };

  home.sessionVariables = systemd.user.sessionVariables;
}
