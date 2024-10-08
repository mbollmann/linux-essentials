;; All major editing modes and settings for them
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;; org-mode
(straight-use-package 'org)
(straight-use-package 'org-autolist)
;(setq org-log-done t)
;(setq org-agenda-files (list "~/Dropbox/org-files/agenda-work.org"
;                             "~/Dropbox/org-files/agenda-home.org"))
;(setq org-default-notes-file "~/Dropbox/org-files/notes.org")
  ; convenience features for lists
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
  ; force loading of Markdown exporter
(eval-after-load "org" '(require 'ox-md nil t))

;; Treat .h files as C++ files (instead of plain C)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; python-mode (Emacs 23 ships with python.el, but this is better)
(straight-use-package 'python-mode)
(straight-use-package 'python-docstring)
(autoload 'python-mode "python-mode" "" t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; xonsh scripts
(add-to-list 'auto-mode-alist '("\\.xsh$" . python-mode))

;; markdown-mode
(straight-use-package 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.page$" . markdown-mode))

;; R-markdown-mode
(use-package poly-markdown)

;; yaml-mode
(use-package yaml-mode
  :mode "\\.ya?ml\\'"
  :bind (:map yaml-mode-map
              ("C-m" . newline-and-indent))
  )

;; cmake-mode (hook to .cmake is defined automatically)
(use-package cmake-mode
  :mode "CMakeLists\\.txt\\'|\\.toolchain\\'"
  )

(use-package fish-mode)

;; web-mode (HTML, PHP, JS) and js2-mode for pure .js files
(use-package web-mode
  :mode (("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.js\\'" . js2-mode))
  )
(use-package multi-web-mode
  :requires web-mode
  :config
  (setq mweb-default-major-mode 'web-mode)
  (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                    (js2-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("htm" "html" "php" "phtml" "php4" "php5" "template"))
  (setq css-indent-offset 2)
  )

;; sass-mode for SASS files
(use-package sass-mode
  :mode "\\.sass\\'")
(use-package scss-mode
  :mode "\\.scss\\'")

;; CSS color values colored by themselves
(use-package rainbow-mode
  :hook
  css-mode emacs-lisp-mode less-css-mode
  )

;; LaTeX/AucTeX
;(require 'fast-latex-input)

;; Apache mode
(straight-use-package 'apache-mode)
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;; justfiles
(straight-use-package 'just-mode)
(add-to-list 'auto-mode-alist '("justfile\\'"  . just-mode))

(use-package typst-ts-mode
  :straight '(:type git :host codeberg :repo "meow_king/typst-ts-mode"
                    :files (:defaults "*.el"))
  :custom
  ;; don't add "--open" if you'd like `watch` to be an error detector
  (typst-ts-mode-watch-options "--open")
  :config
  (add-to-list 'treesit-language-source-alist
               '(typst "https://github.com/uben0/tree-sitter-typst"))
)

(provide 'major-modes)
