{ pkgs, ... }:
{

  ## TODO FULLY split dependencies into devShells
  ##      BUT how services dependently enabled?

  environment.systemPackages = with pkgs; [
    nil
    ccls
    python3
    php
    rust-analyzer
    pandoc
    ripgrep
    gopls
    vscode-langservers-extracted
    lua-language-server
    phpactor
  ] ++ (with nodePackages; [
    bash-language-server
    yaml-language-server
  ]);

  ## TODO Spacemacs config persistence

  services.emacs = {
    enable = true;
    package =
      with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (
        epkgs: with epkgs; [
          vterm

          ## TODO overlay for emacs packages

          (rime.overrideAttrs
            (old: {
              recipe = pkgs.writeText "recipe" ''
                (rime :repo "DogLooksGood/emacs-rime"
                      :files (:defaults "lib.c" "Makefile" "librime-emacs.so")
                      :fetcher github)
              '';
              postPatch = old.postPatch or "" + ''
                emacs --batch -Q -L . \
                    --eval "(progn (require 'rime) (rime-compile-module))"
              '';
              buildInputs = old.buildInputs ++ (with pkgs; [ librime ]);
            }))
          treesit-grammars.with-all-grammars
        ]
      ));
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      (nerdfonts.override { fonts = [ "Hack" ]; })
      wqy_zenhei
      unifont
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans CJK SC" "Noto Sans CJK TC" "Noto Sans CJK JP" "Noto Color Emoji" ];
        monospace = [ "Hack Nerd Font Mono" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
