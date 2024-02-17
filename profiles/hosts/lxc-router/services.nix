{ pkgs , ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      ## HOME ASSISTANT
      homeassistant = {
        image = "ghcr.nju.edu.cn/home-assistant/home-assistant:stable";
        volumes = [
          "home-assistant:/config"
          "/run/dbus:/run/dbus:ro"
        ];
        environment.TZ = "Asia/Shanghai";
        extraOptions = [
          "--network=host"
        ];
      };
      ## AUTO BANGUMI
      autobangumi = {
        image = "ghcr.nju.edu.cn/estrellaxd/auto_bangumi:latest";
        ports = ["7892:7892"];
        volumes = [
          "auto-bangumi-config:/app/config"
          "auto-bangumi-data:/app/data"
        ];
        environment = {
          TZ = "Asia/Shanghai";
          UMASK = "022";
        };
      };
    };
  };

  services = {
    plex = {
      enable = true;
      openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [
    qbittorrent-nox
  ];
  /*
  systemd.services."qbittorrent-nox" = {
    wants = ["network-online.target"];
    after = [
      "local-fs.target"
      "network-online.target"
      "nss-lookup.target"
    ];
    serviceConfig = {
      Type = "simple";
      PrivateTmp = false;
      ExecStart = "${pkgs.qbittorrent.nox}/bin/qbittorrent-nox";
      TimeoutStopSec = 1800;
    };
  };

  systemd.targets.multi-user.wants = ["qbittorrent-nox.service"]
  */
}
