{ pkgs, ... }:
{
  programs.emacs = {
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

  ## TODO FULLY split dependencies into devShells
  ##      BUT how services dependently enabled?

  home.packages = with pkgs; [
    nil
    ccls
    python3
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
    client = {
      enable = true;
    };
  };

}
