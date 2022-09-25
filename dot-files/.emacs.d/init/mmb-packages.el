(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;(package-initialize)

(setq url-http-attempt-keepalives nil)

(defvar mmb-packages
  '(async
    auto-complete
    benchmark-init
    browse-kill-ring
    dash
    epl
    esup
    fuzzy
    highlight-symbol
    ido-completing-read+
    let-alist
    move-text
    pkg-info
    popup
    powerline
    s
    seq
    smart-mode-line
    smart-mode-line-powerline-theme
    solarized-theme
    spaceline
    tabbar
    use-package
    with-editor

    aas
    anzu
    ess
    apache-mode
    cmake-mode
    fish-mode
    god-mode
    haml-mode
    js2-mode
    markdown-mode
    multi-web-mode
    php-mode
    poly-markdown
    python-mode
    python-docstring
    rust-mode
    sass-mode
    scss-mode
    yaml-mode

    cdlatex
    yasnippet

    all-the-icons
    discover-my-major
    eyebrowse
    expand-region
    google-maps
    google-this
    google-translate
    magit
    magit-gitflow
    magit-popup
    magit-todos
    git-commit
    neotree
    org
    org-autolist
    ox-gfm
    w3m)
  "A list of packages to ensure are installed at launch.")

(defun mmb-packages-installed-p ()
  (cl-loop for p in mmb-packages
           when (not (package-installed-p p)) do (cl-return nil)
           finally (cl-return t)))

(unless (mmb-packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p mmb-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'mmb-packages)
