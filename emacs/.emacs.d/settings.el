;;; settings.el --- General Emacs settings -*- lexical-binding: t; -*-

;; ----- Core Settings -----

(setq auto-save-default nil
      make-backup-files nil
      vc-follow-symlinks t
      native-comp-async-report-warnings-errors nil
      ad-redefinition-action 'accept
      global-auto-revert-non-file-buffers t
      dired-kill-when-opening-new-dired-buffer t
      delete-by-moving-to-trash t)

;; ----- Core Modes -----

(repeat-mode 1)
(savehist-mode 1)
(xterm-mouse-mode 1)
(tab-bar-history-mode 1)
(auto-save-visited-mode 1)
(global-auto-revert-mode 1)

;; ----- Org Mode -----

(setq org-ellipsis " ▾"
      org-startup-folded 'content
      org-cycle-separator-lines 2)

(add-hook 'org-mode-hook #'org-indent-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

(provide 'settings)
