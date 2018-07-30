(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq package-archive-priorities
      '(("melpa-stable" . 20)
        ("melpa" . 0)
        ("gnu" . 20)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; Don't clutter the current directory with backups. Save them in a
;; separate directory.
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

;; Open config (this file)
(global-set-key (kbd "<f12>") (lambda () (interactive) (find-file user-init-file)))

;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "Felytic"
      user-mail-address "felytic@gmail.com")

;; Always load newest byte code
(setq load-prefer-newer t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
; (setq use-package-verbose t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(setq-default fill-column 80)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)

(set-face-attribute 'default nil :font "xos4 Terminess Powerline-14")

(add-hook 'prog-mode-hook 'hs-minor-mode)

;;;; ====================== Packages ======================

(use-package evil
  :config
  (evil-mode 1))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package linum-relative
    :config
    (add-hook 'prog-mode-hook 'linum-relative-mode))

(use-package neotree
  :config
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter-vertical-split)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter-horizontal-split)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "C-RET") 'neotree-change-root)

  (evil-define-key 'normal neotree-mode-map "d" 'neotree-delete-node)
  (evil-define-key 'normal neotree-mode-map "i" 'neotree-create-node)
  (evil-define-key 'normal neotree-mode-map "r" 'neotree-rename-node)
  (evil-define-key 'normal neotree-mode-map "[" 'neotree-select-previous-sibling-node)
  (evil-define-key 'normal neotree-mode-map "]" 'neotree-select-next-sibling-node)
  (evil-define-key 'normal neotree-mode-map "H" 'neotree-hidden-file-toggle)
  (evil-define-key 'normal neotree-mode-map "u" 'neotree-refresh)

  (set-face-foreground 'neo-vc-edited-face "#fe8019")
  (set-face-foreground 'neo-vc-added-face "#b8bb26")
  (set-face-foreground 'neo-vc-removed-face "#fb4933")

  (set-face-foreground 'neo-dir-link-face "#87af87")
  (set-face-foreground 'neo-file-link-face "#f4e8b2")
  (set-face-foreground 'neo-expand-btn-face "#ffaf00")

  (setq neo-autorefresh nil)
  (setq neo-theme 'arrow)
  (setq neo-vc-integration '(face))
  (add-hook 'after-init-hook 'neotree-toggle)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (global-set-key [f2] 'neotree-toggle))

(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t))

(use-package find-file-in-project)

(use-package magit)

(use-package git-gutter-fringe
  :config
  (global-set-key (kbd "C-{") 'git-gutter:previous-hunk)
  (global-set-key (kbd "C-}") 'git-gutter:next-hunk)
  (global-set-key (kbd "U") 'git-gutter:revert-hunk)

  (set-face-background 'git-gutter:modified "#fe8019")
  (set-face-background 'git-gutter:added "#b8bb26")
  (set-face-background 'git-gutter:deleted "#fb4933")

  (set-face-foreground 'git-gutter:modified "#fe8019")
  (set-face-foreground 'git-gutter:added "#b8bb26")
  (set-face-foreground 'git-gutter:deleted "#fb4933")

  (fringe-mode 2)
  (setq git-gutter:ask-p nil)
  (setq git-gutter:update-interval 2)
  (global-git-gutter-mode t))


(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package anaconda-mode
  :config
  (global-set-key (kbd "C-0") 'anaconda-mode-find-definitions)
  (global-set-key (kbd "C-9") 'anaconda-mode-find-definitions)
  (global-set-key (kbd "C-8") 'anaconda-mode-find-references)
  (add-hook 'python-mode-hook 'anaconda-mode))

(use-package company-anaconda)

(use-package company
  :config
  (add-to-list 'company-backends '(company-anaconda :with company-capf))
  (add-hook 'after-init-hook 'global-company-mode)
  (add-to-list 'company-backends 'company-anaconda))


(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'character)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package imenu-list
  :config
  (global-set-key (kbd "<f4>") #'imenu-list-smart-toggle))

(use-package projectile
  :config
  (projectile-global-mode t))

(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))

(use-package helm-projectile
  :bind (("C-S-P" . helm-projectile-switch-project)
	 :map evil-normal-state-map
	 ("C-p" . helm-projectile))
  :ensure t)

(use-package helm-ag
  :config
  (global-set-key [f5] 'helm-projectile-ag))
