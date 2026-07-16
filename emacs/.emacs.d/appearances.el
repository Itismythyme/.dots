;;; appearance.el --- UI configuration -*- lexical-binding: t; -*-

(setq inhibit-startup-screen t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)
(column-number-mode 1)

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))

(load-theme 'noctalia t)

(set-face-attribute 'default nil
                    :family "Iosevka Term"
                    :height 160)

(add-to-list 'default-frame-alist
             '(font . "Iosevka Term-16"))

(provide 'appearance)
