{ ... }:

{
  # For distribute build servers
  nix.settings.trusted-users = [ "builder" ];

  users.users.builder = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN/OJ9EX/BImwkf+Fej7hteHTgPiuDwGkkoz69Niwu0i"
    ];
  };
}
