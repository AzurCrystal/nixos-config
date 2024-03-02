{ pkgs, ... }:
{
  programs.sway.extraPackages = with pkgs; [
      obs-studio
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-gstreamer
      #obs-studio-plugins.obs-ndi
  ];
}
