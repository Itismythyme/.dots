;;; init.el --- Main entry point -*- lexical-binding: t; -*-

; Load config files
(load (expand-file-name "packages.el" user-emacs-directory))
(load (expand-file-name "appearances.el" user-emacs-directory))
(load (expand-file-name "settings.el" user-emacs-directory))
(load (expand-file-name "keybinds.el" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auctex cape cdlatex corfu evil-collection marginalia orderless
	    pdf-tools vertico yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
