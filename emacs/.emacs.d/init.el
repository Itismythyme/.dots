;; ----- Repos -----

;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; ----- Installing Packages -----

(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; General Packages
(use-package denote)
(use-package quickrun)

(use-package vertico
  :init
  (vertico-mode))

;; LaTeX
(use-package auctex)
(use-package cdlatex)
(use-package pdf-tools)
(use-package auctex-latexmk)

;;; ----- LaTeX -----
;; PDF View
(pdf-tools-install)

(setq TeX-view-program-selection
      '((output-pdf "PDF Tools")))

;; latexmk
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; CDLaTeX
(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)   ; with AUCTeX LaTeX mode

;; ----- Evil mode -----

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))


;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))


;; ----- Core settings ------
;; Instruct auto-save-mode to save to the current file, not a backup file
(setq auto-save-default nil
make-backup-files nil
vc-follow-symlinks t
native-comp-async-report-warnings-errors nil
ad-redefinition-action 'accept
global-auto-revert-non-file-buffers t)

;; Core modes
(repeat-mode 1)                ;; Enable repeating key maps
(savehist-mode 1)              ;; Save minibuffer history
(scroll-bar-mode 0)            ;; Hide the scroll bar
(xterm-mouse-mode 1)           ;; Enable mouse events in terminal Emacs
(column-number-mode 1)         ;; Show column number on mode line
(tab-bar-history-mode 1)       ;; Remember previous tab window configurations
(auto-save-visited-mode 1)     ;; Auto-save files at an interval
(global-visual-line-mode 1)    ;; Visually wrap long lines in all buffers
(global-auto-revert-mode 1)    ;; Refresh buffers with changed local files

;; ----- Line numbers in left margin -----
(global-display-line-numbers-mode 1)

;;; ----- Essential Org Mode Configuration -----

(setq org-ellipsis " ▾"
      org-startup-folded 'content
      org-cycle-separator-lines 2)

;; Indent org-mode buffers for readability
(add-hook 'org-mode-hook #'org-indent-mode)

;; Set up Org Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

;; Use org-tempo
(use-package org-tempo
  :ensure nil
  :demand t
  :config
  (dolist (item '(("sh" . "src sh")
                  ("el" . "src emacs-lisp")
                  ("li" . "src lisp")
                  ("sc" . "src scheme")
                  ("ts" . "src typescript")
                  ("py" . "src python")
                  ("yaml" . "src yaml")
                  ("json" . "src json")
                  ("einit" . "src emacs-lisp :tangle emacs/init.el")
                  ("emodule" . "src emacs-lisp :tangle emacs/modules/dw-MODULE.el")))
    (add-to-list 'org-structure-template-alist item)))

;;; ----- Dired -----

  (setq dired-kill-when-opening-new-dired-buffer t
        delete-by-moving-to-trash t)

;; ----- Theme -----
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'noctalia t)


;; ----- font -----

(set-face-attribute 'default nil
                    :family "Iosevka Term"
                    :height 160)

(add-to-list 'default-frame-alist '(font . "Iosevka Term-16"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
