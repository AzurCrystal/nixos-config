{ ... }:
{
  services = {
    psd = {
      enable = true;
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governer = "powersave";
          turbo = "never";
        };
        charger = {
          governer = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
