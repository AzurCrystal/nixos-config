;;; package --- Summary
;;; Commentary:
(require 'package)

;;; Code:
(setq package-archives
	     '(("melpa"  . "https://mirrors.bfsu.edu.cn/elpa/melpa/")
	       ("gnu"    . "https://mirrors.bfsu.edu.cn/elpa/gnu/")
	       ("org"    . "https://mirrors.bfsu.edu.cn/elpa/org/")
	       ("nongnu" . "https://mirrors.bfsu.edu.cn/elpa/nongnu/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :config
  (evil-set-undo-system 'undo-redo))
  :init
  (evil-mode 1)

(use-package atom-one-dark-theme)
(use-package magit)
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files))
  :config
  (helm-mode 1))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-limit 10
	company-show-quick-access t
	company-idle-delay .2
	company-minimum-prefix-length 1
	company-tooltip-align-annotations t
	company-selection-wrap-around t
	company-transformers '(company-sort-by-occurrence)
	))

(use-package company-box
  :if window-system
  :hook (company-mode . company-box-mode))

(use-package flycheck
  :init
  (setq flycheck-emacs-lisp-load-path 'inherit)
  :config
  (setq truncate-lines nil)
  :hook
  (prog-mode . flycheck-mode))

(use-package lsp-mode
  :commands (lsp)
  :hook ((() . lsp))
  :init
  (setq lsp-auto-configure t
	lsp-auto-guess-root t
	lsp-idle-delay 0.500
	lsp-session-file "~/.emacs.d/.cache/lsp-sessions"))

(use-package lsp-ui
  :after (lsp-mode)
  :commands (lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
	([remap xref-find-references] . lsp-ui-peek-find-references)
	([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	("C-c u" . lsp-ui-mode))
  :hook (lsp-mode . lsp-ui-mode)
  :init
  ;(setq lsp-enbale-symbol-highlighting t)
)

(use-package helm-lsp
  :commands (helm-lsp-workspace-symbol))

(use-package which-key
  :init
  (which-key-mode))

(use-package treemacs
  )

(use-package vterm)
(use-package avy
  :bind
  (("C-j C-SPC" . avy-goto-char-timer)))

(use-package treemacs-evil)

(use-package rime
  :custom
  (default-input-method "rime")
  ;(rime-user-data-dir "~/.local/share/emacs/rime")
  (rime-share-data-dir "~/.local/share/fcitx5/rime" )
  (rime-postframe-style "simple")
  (rime-show-candidate 'posframe)
  )




;(set-frame-font "Hack Nerd Font Mono 12" nil t)
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font Mono 12"))

(setq make-backup-files nil
      auto-save-default nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'atom-one-dark t)
(global-display-line-numbers-mode 1)
(pixel-scroll-precision-mode 1)
(setq display-line-numbers 'relative)
(setq scroll-margin 10
      scroll-conservatively 10
      scroll-step 1 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(lsp-ui lsp-mode flycheck helm evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
