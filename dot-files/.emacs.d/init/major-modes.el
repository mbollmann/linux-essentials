;; All major editing modes and settings for them

;; org-mode
(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox/org-files/agenda-work.org"
                             "~/Dropbox/org-files/agenda-home.org"))
(setq org-default-notes-file "~/Dropbox/org-files/notes.org")
  ; convenience features for lists
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
  ; force loading of Markdown exporter
(eval-after-load "org" '(require 'ox-md nil t))

;; Treat .h files as C++ files (instead of plain C)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; python-mode (Emacs 23 ships with python.el, but this is better)
(autoload 'python-mode "python-mode" "" t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; xonsh scripts
(add-to-list 'auto-mode-alist '("\\.xsh$" . python-mode))

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.page$" . markdown-mode))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook '(lambda ()
   (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; cmake-mode (hook to .cmake is defined automatically)
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.toolchain$" . cmake-mode))

;; web-mode (HTML, PHP, JS) and js2-mode for pure .js files
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(require 'multi-web-mode)
(setq mweb-default-major-mode 'web-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js2-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("htm" "html" "php" "phtml" "php4" "php5" "template"))
(setq css-indent-offset 2)

;; sass-mode for SASS files
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass\\'" . sass-mode))
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; CSS color values colored by themselves
(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
(add-hook 'less-css-mode-hook 'rainbow-mode)

;; Apache mode
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

(provide 'major-modes)
