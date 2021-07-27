(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Okular")
     (output-html "xdg-open"))))
 '(c-basic-offset 4)
 '(indent-tabs-mode nil)
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(eyebrowse-keymap-prefix (kbd "C-c C-e"))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when init-file-debug
  (require 'benchmark-init)
  (benchmark-init/activate)
  (add-hook 'emacs-startup-hook 'benchmark-init/show-durations-tree)
  )

;; Make sure all necessary packages are available
(add-to-list 'load-path "~/.emacs.d/init")
(require 'mmb-packages)

;; hotfix for long startup issues
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

;; Load other configuration files
(add-to-list 'load-path "~/.emacs.d/major-modes")
(add-to-list 'load-path "~/.emacs.d/plugins")

;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(require 'interface)
(require 'major-modes)
(require 'utils)
(require 'plugins)
(require 'key-bindings)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
