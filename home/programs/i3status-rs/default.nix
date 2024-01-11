{
  programs.i3status-rust = {
    enable = true;
    bars = {
      laptop-main = {
        theme = "slick";
        icons = "material-nf";
        blocks = [
          {
            block = "music";
            format = " $icon {$combo.str(max_w:15) $play $next $volume_icon $volume |}";
            player = "com.gitee.gmg137.NeteaseCloudMusicGtk4";
            click = [
              {
                button = "up";
                action = "volume_up";
              }
              {
                button = "down";
                action = "volume_down";
              }
            ];
          }
          {
            block = "cpu";
            interval = 5;
            format = " $icon ";
            format_alt = " $icon $frequency ";
          }
          {
            block = "memory";
            format = " $icon $mem_total_used_percents.eng(w:1) ";
            interval = 10;
            warning_mem = 80;
            critical_mem = 95;
          }
          {
            block = "temperature";
            format = " $icon $max ";
            format_alt = " $icon $min $max $average";
            interval = 10;
            chip = "*-isa-*";
          }
          {
            block = "weather";
            service = {
              name = "openweathermap";
              api_key = "ffb4b488656ac598fa46c987e06ed22e";
              city_id = "1797929";
              units = "metric";
            };
          }
          {
            block = "time";
            interval = 1;
            format = " $timestamp.datetime(f:'%Y/%m/%d %a %H:%M:%S',l:en_GB) ";
          }
          {
            block = "backlight";
            format = " $icon ";
            device = "intel_backlight";
          }
          {
            block = "net";
            format = " $icon ";
            format_alt = " $icon ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
          }
          {
            block = "battery";
            format = " $icon $percentage ";
            driver = "sysfs";
          }
        ];
      };
    };
  };
}
