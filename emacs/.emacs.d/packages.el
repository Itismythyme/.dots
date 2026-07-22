;;; packages.el --- Package configuration -*- lexical-binding: t; -*-

(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/")
             t)

(package-initialize)

(setq use-package-always-ensure t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; ----- General Packages -----

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package corfu
  :init
  (global-corfu-mode)

  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1)
  (corfu-count 10)
  (corfu-cycle t))

(use-package cape
  :after corfu
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; ----- Evil -----

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil
        evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
 :config
  (setq evil-want-integration t)
  (evil-collection-init))


;; ----- Org -----

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


;; ----- Local Packages -----

(add-to-list 'load-path "~/emacs-libvterm/")
(require 'vterm)


;; ----- LaTeX -----

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook ((LaTeX-mode . turn-on-reftex)
         (LaTeX-mode . TeX-fold-mode)
         (LaTeX-mode . prettify-symbols-mode)
         (LaTeX-mode . turn-on-cdlatex)
         (LaTeX-mode . yas-minor-mode))
  :init
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-master nil
        TeX-save-query nil
        TeX-process-asynchronous t)

  :config
  (setq TeX-command-default "LatexMk")

  ;; PDF Tools viewer
  (setq TeX-view-program-selection
        '((output-pdf "PDF Tools")))

  (setq TeX-view-program-list
        '(("PDF Tools" TeX-pdf-tools-sync-view)))

  ;; AUCTeX completion
  (setq TeX-complete-expert-commands t))


(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook (pdf-view-mode . (lambda ()
                           (display-line-numbers-mode -1)))
  :config
  (pdf-tools-install)
  (setq pdf-view-use-scaling t))


(use-package cdlatex
  :after tex
  :hook (LaTeX-mode . turn-on-cdlatex))


(use-package yasnippet
  :hook (LaTeX-mode . yas-minor-mode))


(provide 'packages)
