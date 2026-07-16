;;; init.el --- Main entry point -*- lexical-binding: t; -*-

; Load config files
(load (expand-file-name "packages.el" user-emacs-directory))
(load (expand-file-name "appearances.el" user-emacs-directory))
(load (expand-file-name "settings.el" user-emacs-directory))
(load (expand-file-name "keybinds.el" user-emacs-directory))
