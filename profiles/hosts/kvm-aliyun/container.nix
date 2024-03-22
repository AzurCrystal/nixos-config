{ ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "planarally" = {
        image = "kruptein/planarally:latest";
        volumes = [
          "planarally-data:/planarally/data/"
          "planarally-assets:/planarally/assets/"
        ];
        ports = [
          "8000:8000"
        ];
        extraOptions = [

        ];
      };
    };
  };
}