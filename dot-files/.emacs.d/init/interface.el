;; All customizations related to the interface and/or Emacs core
;; functions

;; color theme
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized-dark t)
(defvar *mmb-current-theme* 'solarized-dark)
(defun solarized-load-theme (theme)
  (load-theme theme t)
  (setq *mmb-current-theme* theme)
  )
(defun solarized-toggle-theme ()
  (interactive)
  (cond ((eq *mmb-current-theme* 'solarized-dark)  (solarized-load-theme 'solarized-light))
        ((eq *mmb-current-theme* 'solarized-light) (solarized-load-theme 'solarized-dark)))
  )

;; Turn off annoying redefinition warning
(setq ad-redefinition-action 'accept)

;; When I was a child, I spake as a child,
;; I understood as a child, I thought as a child:
;; but when I became a man, I put away childish things.
;;   -- 1 Corinthians, 13:11
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; set default font and font size. Only ONE of the following should be enabled!
;(set-face-attribute 'default nil :family "Hack" :height 110)
;(require 'fira-code)
(set-default-font "Hack-11")

;; default line spacing, original value was nil
(setq-default line-spacing 1)

;; NEVER use tabs
(setq-default indent-tabs-mode nil)

;; fill column
(setq-default fill-column 80)

;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "xdg-open")

;; display format for line numbers on the left side
(setq linum-format " %d ")

;; ========== Line by line scrolling ==========
;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; delete selections with backspace and overwrite them by starting to type
(delete-selection-mode t)

;; ========== Place Backup Files in Specific Directory ==========
;; Enable backup files.
(setq make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 4
  kept-old-versions 2
  version-control t)

;; for handling open files with same names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; delete trailing whitespace and blank lines at the end before saving files
;(add-hook 'before-save-hook 'delete-trailing-whitespace)
;(add-hook 'before-save-hook
;          '(lambda ()
;             (interactive)
;             (save-excursion
;              (save-restriction
;               (widen)
;               (goto-char (point-max))
;               (delete-blank-lines)))))

;; show column number in mode line
(column-number-mode 1)

;; automatically insert newline at the end of every file
(setq require-final-newline 'ask)

;; Interactively Do Things - UX improvement for the minibuffer
(ido-mode 1)
(setq ido-everywhere t
      ido-enable-flex-matching t
      ido-ignore-buffers '("\\` " "*Messages*" "*Completions*" "*Buffer List*"
                           "*scratch*" "*Help*" "*Backtrace*"))

;; auto-update imenu index
(setq imenu-auto-rescan t)

;; compact completion suggestions in the minibuffer
(icomplete-mode 1)

;; make point end up at the beginning of the match when pressing RET
;; during isearch
(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
(defun my-goto-match-beginning ()
  (when (and isearch-forward isearch-other-end (not isearch-mode-end-hook-quit))
    (goto-char isearch-other-end)))

;; ========== Intuitive window resizing ==========
;; <http://vickychijwani.me/nuggets-from-my-emacs-part-i/>
(defun xor (b1 b2)
  (or (and b1 b2)
      (and (not b1) (not b2))))

(defun move-border-left-or-right (arg dir)
  "General function covering move-border-left and move-border-right. If DIR is
     t, then move left, otherwise move right."
  (interactive)
  (if (null arg) (setq arg 3))
  (let ((left-edge (nth 0 (window-edges))))
    (if (xor (= left-edge 0) dir)
        (shrink-window arg t)
        (enlarge-window arg t))))

(defun move-border-up-or-down (arg dir)
  "General function covering move-border-up and move-border-down. If DIR is
     t, then move up, otherwise move down."
  (interactive)
  (if (null arg) (setq arg 3))
  (let ((top-edge (nth 1 (window-edges))))
    (if (xor (= top-edge 0) dir)
        (shrink-window arg nil)
        (enlarge-window arg nil))))

(defun move-border-left (arg)
  (interactive "P")
  (move-border-left-or-right arg t))

(defun move-border-right (arg)
  (interactive "P")
  (move-border-left-or-right arg nil))

(defun move-border-up (arg)
  (interactive "P")
  (move-border-up-or-down arg t))

(defun move-border-down (arg)
  (interactive "P")
  (move-border-up-or-down arg nil))

;; fullscreen magit status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(defun amaroid-show-welcome-message ()
  "Shows welcome message.  Yay!"
  (interactive)
  (message "Initialized in %s.   ><(((º>" (emacs-init-time)))
(add-hook 'emacs-startup-hook 'amaroid-show-welcome-message)

(provide 'interface)
