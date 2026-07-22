;;; appearance.el --- UI configuration -*- lexical-binding: t; -*-

;; ----- Startup -----

(setq inhibit-startup-screen t
      initial-scratch-message nil)

;; ----- UI Cleanup -----

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; ----- Line Numbers -----

(global-display-line-numbers-mode 1)

(setq display-line-numbers-type 'relative)

;; ----- Visual Editing -----

(global-visual-line-mode 1)
(column-number-mode 1)

(global-hl-line-mode 1)

;; ----- Theme -----

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))

(load-theme 'noctalia t)

;; ----- Font -----

(set-face-attribute 'default nil
                    :family "Iosevka Term"
                    :height 130)

(add-to-list 'default-frame-alist
             '(font . "Iosevka Term-13"))

;; ----- Neovim-like Spacing -----

(set-fringe-mode 8)

(setq-default line-spacing 0.15)

;; ----- Scrolling -----

(setq scroll-margin 5
      scroll-conservatively 101
      scroll-preserve-screen-position t)


;; ----- Cleaner Modeline -----

(set-face-attribute 'mode-line nil
                    :box nil)

(set-face-attribute 'mode-line-inactive nil
                    :box nil)

(provide 'appearance)
