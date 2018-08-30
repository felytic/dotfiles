;;;; ========================== General =======================================

(setq user-full-name "Felytic" user-mail-address "felytic@gmail.com")

;; Open config (this file)
(global-set-key [f12] (lambda () (interactive) (find-file user-init-file)))

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Hide/show blocks
(add-hook 'prog-mode-hook 'hs-minor-mode)

;;;; =========================== Hotkeys ======================================

(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)


(defun add-py-debug ()
    (interactive)
    (newline-and-indent)
    (insert "import pdb; pdb.set_trace()  # BREAKPOINT\n"))


(defun goto-py-debug()
  (interactive)
  (search-forward-regexp "^[ ]*import pdb; pdb.set_trace()")
  (move-beginning-of-line 1))

(global-set-key [f9] 'add-py-debug)
(global-set-key [f8] 'goto-py-debug)

(defun toggle-fold ()
  "Toggle fold all lines larger than indentation on current line."
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))

(global-set-key [C-tab] 'toggle-fold)


;;;; ============================== UI ========================================

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(set-face-attribute 'default nil :font "xos4 Terminess Powerline-14")


;;;; ========================= Packages configuration =========================

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq package-archive-priorities
      '(("melpa-stable" . 20)
        ("melpa" . 0)
        ("gnu" . 20)))

;; Don't flud this file with custom vars
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; Always load newest byte code
(setq load-prefer-newer t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)


;;;; ============================ Packages list ===============================

(use-package evil
  :config
  (define-key evil-normal-state-map (kbd "H") 'evil-first-non-blank)
  (define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
  (evil-mode 1))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package linum-relative
    :config
    (setq linum-relative-current-symbol "")
    (linum-relative-global-mode))

(use-package jedi
  :init
  (jedi:install-server)
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))

(use-package auto-complete
  :config
  (ac-config-default))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package ein)

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
  (setq neo-theme 'ascii)
  (setq neo-vc-integration '(face))
  (setq neo-mode-line-type 'neotree)
  (add-hook 'after-init-hook 'neotree-toggle)
  (setq neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "__pycache__"))
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (global-set-key [f2] 'neotree-toggle))

(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t))

(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

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
  :config
  (helm-mode 1)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (setq helm-split-window-inside-p t)
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

(use-package magit)

(use-package git-gutter-fringe
  :config
  (global-set-key (kbd "C-{") 'git-gutter:previous-hunk)
  (global-set-key (kbd "C-}") 'git-gutter:next-hunk)
  (define-key evil-normal-state-map (kbd "U") 'git-gutter:revert-hunk)

  (set-face-background 'git-gutter:modified "#fe8019")
  (set-face-background 'git-gutter:added "#b8bb26")
  (set-face-background 'git-gutter:deleted "#fb4933")

  (set-face-foreground 'git-gutter:modified "#fe8019")
  (set-face-foreground 'git-gutter:added "#b8bb26")
  (set-face-foreground 'git-gutter:deleted "#fb4933")

  (setq git-gutter:ask-p nil)
  (setq git-gutter:update-interval 2)
  (global-git-gutter-mode t))


(use-package dimmer
  :config
  (setq dimmer-fraction 0.3)
  (dimmer-mode))

(use-package spacemacs-theme
  :init
  (setq spacemacs-theme-org-agenda-height nil)
  (setq spacemacs-theme-org-height nil))

(use-package spaceline
  :demand t
  :init
  (setq powerline-default-separator 'arrow-fade)
  :config
  (require 'spaceline-config)
  (spaceline-helm-mode)
  (spaceline-emacs-theme))

(use-package which-key
  :config
  (which-key-mode))

(use-package dockerfile-mode)

(use-package yaml-mode)

(use-package vimrc-mode)

;;; .emacs.el ends here
