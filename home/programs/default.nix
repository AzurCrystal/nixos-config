{
  imports = [
    ./fcitx5
    ./alacritty
    ./i3status-rs
    ./zsh
    ./emacs
    ./rofi
    ./git
  ];
  programs = {
    bottom = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    home-manager = {
      enable = true;
    };
    fzf = {
      enable = true;
    };
  };
}
