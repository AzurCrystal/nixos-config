{ pkgs, ... }:

{
  environment.etc."greetd/environments".text = ''
    sway
  '';

  environment.etc."greetd/sway-config".text = ''
    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"

    bindsym Mod4+shift+e exec swaynag \
        -t warning \
        -m 'Power Menu' \
        -b 'Poweroff' 'systemctl poweroff' \
        -b 'Reboot' 'systemctl reboot'
  '';

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config /etc/greetd/sway-config";
      };
    };
  };
}
