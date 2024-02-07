{ ... }:

{
  imports = [
    ./sway.nix
    ./greeterd.nix
    ./fonts.nix
    ./obs-studio.nix #FIXME ONLY sway specific obs should in 
  ];
}
