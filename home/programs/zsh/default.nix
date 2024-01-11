{
  home.file = {
    zshrc = {
      enable = true;
      source = ./zshrc;
      target = "/home/azurcrystal/.zshrc";
    };
  };
  programs.zsh = {
    enable = false;
    package = null;
  };
}
