(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "lualatex")
 '(LaTeX-command-style
   '(("" "%(latex) %(file-line-error) %(extraopts) %(output-dir) %S%(PDFout)")))
 '(TeX-PDF-mode t)
 '(TeX-command "luatex")
 '(TeX-view-program-selection
   '(((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Okular")
     (output-html "xdg-open")))
 '(c-basic-offset 4)
 '(custom-safe-themes
   '("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))
 '(eyebrowse-keymap-prefix (kbd "C-c C-e"))
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(auctex w3m ox-gfm org-autolist neotree magit-todos magit-gitflow magit google-translate google-this google-maps expand-region eyebrowse discover-my-major all-the-icons yasnippet cdlatex yaml-mode scss-mode sass-mode rust-mode python-docstring python-mode poly-markdown php-mode multi-web-mode markdown-mode js2-mode haml-mode god-mode fish-mode cmake-mode apache-mode ess anzu aas with-editor use-package tabbar spaceline solarized-theme smart-mode-line-powerline-theme smart-mode-line powerline pkg-info move-text ido-completing-read+ highlight-symbol fuzzy esup epl dash browse-kill-ring benchmark-init auto-complete async))
 '(safe-local-variable-values '((encoding . utf-8)))
 '(warning-suppress-types '((comp) (yasnippet backquote-change))))
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
(load "mmb-packages")

;; hotfix for long startup issues
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

;; Load other configuration files
(add-to-list 'load-path "~/.emacs.d/major-modes")
(add-to-list 'load-path "~/.emacs.d/plugins")

;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(load "interface")
(load "major-modes")
(require 'utils)
(load "plugins")
(load "key-bindings")

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
