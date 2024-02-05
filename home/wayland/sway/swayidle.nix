{ ... }:
{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "swaylock -f -c 000000";
      }
    ];
    timeouts = [
      {
        timeout = 240;
        command = "swaylock -f -c 000000";
      }
      {
        timeout = 360;
        command = "systemctl suspend";
      }
    ];
  };
}
