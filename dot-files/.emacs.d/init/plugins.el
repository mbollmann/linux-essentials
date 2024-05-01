;; External plug-ins
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;;;; spaceline
(straight-use-package 'spaceline)
(require 'spaceline-config)
(spaceline-emacs-theme)
(setq spaceline-workspace-numbers-unicode t)

;;;; grant fuzzy-searching superpowers to isearch
; TODO: why is this not working?
; (straight-use-package 'fuzzy)
; (turn-on-fuzzy-isearch)

;;;; use anzu-mode everywhere
(straight-use-package 'anzu)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
(setq anzu-cons-mode-line-p nil)

;;;; ido-enabled jump-to-definition (better than imenu, works in many modes)
(autoload 'idomenu "idomenu" nil t)

;;;; ido everywhere, seriously
(ido-ubiquitous-mode t)

;;;; auto-complete
(straight-use-package 'auto-complete)
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
(setq eyebrowse-keymap-prefix (kbd "C-ä C-e"))
(straight-use-package 'eyebrowse)
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
(straight-use-package 'god-mode)

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

;; magit and extensions
(use-package magit
  :bind (("C-x g s" . magit-status)
         ("<f4>" . magit-status)
         ("C-<f4>" . magit-status))
  :config
  (progn (define-key magit-status-mode-map (kbd "q") 'magit-quit-session))
)
(use-package magit-gitflow
  :defer t
  :hook (magit-mode . turn-on-magit-gitflow)
  )
(use-package magit-todos
  :init
  (add-hook 'magit-mode
            (let ((inhibit-message t)) (magit-todos-mode 1)))
  :config
  (transient-append-suffix 'magit-status-jump '(0 0 -1)
    '("T " "Todos" magit-todos-jump-to-todos))
  )

;; dired+
(use-package dired+ :defer t)
(use-package neotree :defer t
  :commands neotree-toggle
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  :bind ("<f5>" . neotree-toggle)
  )

;; icon goodness
(use-package font-lock+)
(use-package all-the-icons)

(straight-use-package 'esup)
(setq esup-depth 0)

(provide 'plugins)
