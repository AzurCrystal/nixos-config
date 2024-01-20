{ ... }:

{
  users.users.azurcrystal.extraGroups = [
    "docker"
  ];
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
    };
  };
}
