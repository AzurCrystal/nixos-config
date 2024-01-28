{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "leftcontrol";
            leftcontrol = "capslock";
          };
        };
      };
    };
  };
}
