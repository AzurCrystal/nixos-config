{ ... }:
{
  imports = [
    ../../base/settings
  ];

  # FIXME colmena needs a non-interactive sudo

  config.security.sudo = {
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };
}
