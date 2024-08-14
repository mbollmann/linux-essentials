;; Customized key-bindings

;; enable dead keys
(require 'iso-transl)

(global-set-key (kbd "C-<tab>") 'next-multiframe-window)
(global-set-key (kbd "C-S-<iso-lefttab>") 'previous-multiframe-window)

;; browse-kill-ring
(straight-use-package 'browse-kill-ring)
(global-set-key (kbd "C-c y") 'browse-kill-ring)

;; scroll-all-mode
(global-set-key (kbd "C-c s a") 'scroll-all-mode)
(global-set-key (kbd "<Scroll_Lock>") 'scroll-all-mode)

;;;; rename, delete, reopen as root
(global-set-key (kbd "C-x C-d") 'delete-current-file-and-buffer)
(global-set-key (kbd "C-x C-r") 'rename-current-file-and-buffer)
(global-set-key (kbd "C-x C-a") 'sudo-edit-current-file)

;; formatting stuff
(global-set-key (kbd "C-c C-r") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-ä C-w") 'delete-trailing-whitespace)

;; move-text
(straight-use-package 'move-text)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; expand-region
(straight-use-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; keybindings for window resizing (defined in interface.el)
(global-set-key (kbd "M-S-<left>") 'move-border-left)
(global-set-key (kbd "M-S-<right>") 'move-border-right)
(global-set-key (kbd "M-S-<up>") 'move-border-up)
(global-set-key (kbd "M-S-<down>") 'move-border-down)

;;;; home / C-a toggle between first non-blank character of line and beginning of line
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

;;;; F11 for fullscreen (Emacs default, but make it work in God mode too)
(global-set-key (kbd "C-<f11>") 'toggle-frame-fullscreen)

;;;; F12 to toggle theme
(global-set-key (kbd "<f12>") 'solarized-toggle-theme)

;;;; auto-complete-mode
;(eval-after-load "auto-complete"
;  '(progn (define-key ac-mode-map (kbd "TAB") 'auto-complete)))

;; ido enhancement for imenu-mode (code navigation by function name)
(global-set-key (kbd "M-<dead-circumflex>") 'idomenu)

;; highlighting symbols
(straight-use-package 'highlight-symbol)
(global-set-key (kbd "C-<f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f3>") 'highlight-symbol-next)
(global-set-key (kbd "S-<f3>") 'highlight-symbol-prev)
(global-set-key (kbd "M-<f3>") 'highlight-symbol-query-replace)

;;;; my-desktop
(require 'my-desktop)
(global-set-key (kbd "C-x x r") 'my-desktop-read)
(global-set-key (kbd "C-x x s") 'my-desktop-save)
(global-set-key (kbd "C-x x c") 'my-desktop-change)
(global-set-key (kbd "C-x x d") 'my-desktop-save-and-clear)
(global-set-key (kbd "C-x x n") 'my-desktop-name)

;;;; eyebrowse
(eyebrowse-setup-opinionated-keys)  ;; this makes M-0 to M-9 work as with escreen
(setq eyebrowse-new-workspace t)    ;; empty workspace on new window
(global-set-key (kbd "<f9>") 'eyebrowse-create-window-config)
(global-set-key (kbd "S-<f9>") 'eyebrowse-close-window-config)

;;;; flycheck
;(global-set-key (kbd "<f5>") 'flycheck-previous-error)
;(global-set-key (kbd "<f6>") 'flycheck-next-error)
;(global-set-key (kbd "<f7>") 'flycheck-list-errors)
;(global-set-key (kbd "S-<f7>") 'flycheck-mode)

;;;; org-mode
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;;;; god-mode, and stuff that exists mainly for use in god-mode
(define-key god-local-mode-map (kbd ".") 'repeat)
(global-set-key (kbd "<escape>") 'god-local-mode)
(global-set-key (kbd "C-ü") 'undo)
(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-u") 'list-buffers)

;;;; neotree
(straight-use-package 'neotree)
(setq neo-smart-open t)
(global-set-key (kbd "<f5>") 'neotree-toggle)

;;;; Google stuff
(straight-use-package 'google-this)
(global-set-key (kbd "C-c g") 'google-this-mode-submap)
(straight-use-package 'google-translate)
(require 'google-translate-default-ui)
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c T") 'google-translate-query-translate)

;;;; Shell
(global-set-key (kbd "M-°") 'shell-command-on-region)
(global-set-key (kbd "M-\"") 'shell-command-on-buffer)

(provide 'key-bindings)
