{ config, pkgs, ... }:

{
  nix.settings.trusted-users = [ "azurcrystal" ];
  users.users.azurcrystal = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    uid = 1000;
    home = "/home/azurcrystal";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7scDPGko5y8BMq+8qu/ezZmaocwFNDUB3NM/ygoHh4"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0Gna1mibX/uXKm7WBK5BrE5F8EF++lx86byIJQ7TTS"
    ];
    hashedPasswordFile = config.sops.secrets."users/azurcrystal/passwd".path;
    shell = pkgs.bash;
  };
}
