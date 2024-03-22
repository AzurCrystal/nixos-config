{ config, lib, ... }:
let
  ph = config.sops.placeholder;
  sopsFilePath = ./secrets.yaml;

in
{
  config.sops.secrets = {
    "xray/listen" = {
      sopsFile = sopsFilePath;
    };
    "xray/port" = {
      sopsFile = sopsFilePath;
    };
    "xray/shortids" = {
      sopsFile = sopsFilePath;
    };
    "xray/clients" = {
      sopsFile = sopsFilePath;
    };
    "xray/dest" = {
      sopsFile = sopsFilePath;
    };
    "xray/serverNames" = {
      sopsFile = sopsFilePath;
    };
    "xray/privateKey" = {
      sopsFile = sopsFilePath;
    };
  };

  config.services.xray = {
    enable = true;
    settingsFile = config.sops.templates."xconfig.json".path;
  };

  config.sops.templates."xconfig.json" = {
    mode = "0444";
    content = lib.mkDefault ''
      {
          "log": {
              "loglevel": "warning"
          },
          "routing": {
              "domainStrategy": "IPIfNonMatch",
              "rules": [
                  {
                      "type": "field",
                      "ip": [
                          "geoip:cn",
                          "geoip:private"
                      ],
                      "outboundTag": "block"
                  }
              ]
          },
          "inbounds": [
              {
                  "listen": "${ph."xray/listen"}",
                  "port": ${ph."xray/port"},
                  "protocol": "vless",
                  "settings": {
                      "clients": [
                         ${ph."xray/clients"}
                      ],
                      "decryption": "none"
                  },
                  "streamSettings": {
                      "network": "tcp",
                      "security": "reality",
                      "realitySettings": {
                          "show": false,
                          "dest": "${ph."xray/dest"}",
                          "serverNames": [
                              ${ph."xray/serverNames"}
                          ],
                          "privateKey": "${ph."xray/privateKey"}",
                          "shortIds": [
                              ${ph."xray/shortids"}
                          ]
                      }
                  },
                  "sniffing": {
                      "enabled": true,
                      "destOverride": [
                          "http",
                          "tls",
                          "quic"
                      ]
                  }
              }
          ],
          "outbounds": [
              {
                  "protocol": "freedom",
                  "tag": "direct"
              },
              {
                  "protocol": "blackhole",
                  "tag": "block"
              }
          ],
          "policy": {
              "levels": {
                  "0": {
                      "handshake": 2,
                      "connIdle": 120
                  }
              }
          }
      }
    '';
  };
}
