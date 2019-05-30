;; External plug-ins

;;;; clean and powerful modeline
;(require 'smart-mode-line)
;(setq sml/theme 'respectful)
;(setq sml/no-confirm-load-theme t)
;(sml/setup)
;(add-to-list 'sml/replacer-regexp-list '("^~/repositories/" ":repo:") t)
;(add-to-list 'sml/replacer-regexp-list '("^~/web/" ":web:") t)
;(set-face-attribute 'mode-line nil :foreground "#f0dfaf" :background "#1e2320" :box nil)
;(set-face-attribute 'mode-line-inactive nil :foreground "#88b090" :background "#2e3330" :box nil)

;;;; compact / hidden minor mode names in the modeline
;(when (require 'diminish nil 'noerror)
;  (eval-after-load "auto-complete"         '(diminish 'auto-complete-mode         " AC"))
;  )

(require 'spaceline-config)
(spaceline-emacs-theme)
(setq spaceline-workspace-numbers-unicode t)

;;;; grant fuzzy-searching superpowers to isearch
(require 'fuzzy)
(turn-on-fuzzy-isearch)

;;;; use anzu-mode everywhere
(require 'anzu)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
(setq anzu-cons-mode-line-p nil)

;;;; ido-enabled jump-to-definition (better than imenu, works in many modes)
(autoload 'idomenu "idomenu" nil t)

;;;; ido everywhere, seriously
(ido-ubiquitous-mode t)

;;;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-show-menu t
      ac-expand-on-auto-complete nil
      ac-quick-help-delay 0.2)
(add-to-list 'ac-modes 'haml-mode)
(ac-config-default)
(ac-linum-workaround) ;; fix for annoying bug with AC + linum mode

(global-auto-complete-mode t)

;;;; eyebrowse
(require 'eyebrowse)
(eyebrowse-mode t)

;; tramp default mode
(setq tramp-default-method "ssh")

;; flycheck
;(require 'flycheck)
;(add-hook 'after-init-hook #'global-flycheck-mode)
;(define-key flycheck-mode-map flycheck-keymap-prefix nil)
;(setq flycheck-keymap-prefix (kbd "C-c f"))
;(define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map)

;;;; godmode
(require 'god-mode)

;; change cursor type when we're in godmode
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'hollow
                      'box)))
(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; toggle god-mode on overwrite
(defun god-toggle-on-overwrite ()
  "Toggle god-mode on overwrite-mode."
  (if (bound-and-true-p overwrite-mode)
      (god-local-mode-pause)
    (god-local-mode-resume)))
(add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

;; use god-mode in isearch
(require 'god-mode-isearch)
(define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)

;; activate god-mode globally
;; -- but only in graphical client, because Escape key (for toggling god-mode)
;;    often doesn't work in terminals
(when (display-graphic-p)
  (god-mode)
  )

;; magit-gitflow extension
(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
(require 'magit-org-todos)
(magit-org-todos-autoinsert)

;; dired+
(require 'dired+)
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; icon goodness
(require 'font-lock+)
(require 'all-the-icons)

(provide 'plugins)
