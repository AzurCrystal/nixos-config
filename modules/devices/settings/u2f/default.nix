{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ccid
  ];

  services = {
    pcscd = {
      enable = true;
    };
    udev = {
      enable = true;
      extraRules = ''
        SUBSYSTEM!="usb", GOTO="canokeys_rules_end"
        ACTION!="add|change", GOTO="canokeys_rules_end"
        ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="42d4", ENV{ID_SMARTCARD_READER}="1"
        LABEL="canokeys_rules_end"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="42d4", TAG+="uaccess", GROUP="plugdev", MODE="0660"
        SUBSYSTEMS=="usb", ATTR{idVendor}=="20a0", ATTR{idProduct}=="42d4", TAG+="uaccess"
      '';
    };
  };

  security.pam.u2f = {
    enable = true;
    cue = true;
    control = "sufficient";
  };
}
