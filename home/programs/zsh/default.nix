{config, ...}:

{
  programs.zsh = {
    enable = false;
    package = null;
  };

  home.file = {
    zshrc = {
      enable = true;
      source = ./zshrc;
      target = "${config.home.homeDirectory}/.zshrc";
    };
  };
}
