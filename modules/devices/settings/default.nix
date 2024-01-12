{ lib, ... }:

{
  imports = [
    ../../base/settings

    ./u2f
    ./polkit
    ./gnupg
    ./network
  ];

  time.timeZone = lib.mkDefault "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
}
