{ ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "dokuwiki-dev" = {
        image = "lscr.io/linuxserver/dokuwiki:latest";
        environment = {
          TZ = "Asia/Shanghai";
          PUID = "1000";
          PGID = "100";
        };
        volumes = [
          "/home/azurcrystal/Gitrepos/dokuwiki:/config"
        ];
        ports = [
          "80:80"
        ];
        extraOptions = [

        ];
      };
    };
  };
}
