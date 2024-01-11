{ ... }:
{
  imports = [
    ../../base/services

    ./systemd
    ./profile-sync-daemon.nix
    ./power-management.nix
    ./input-remapper.nix
  ];
}
