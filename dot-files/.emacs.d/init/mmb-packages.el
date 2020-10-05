(require 'cl)
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
    with-editor

    anzu
    apache-mode
    cmake-mode
    fish-mode
    gitconfig-mode
    gitignore-mode
    god-mode
    haml-mode
    js2-mode
    markdown-mode
    multi-web-mode
    php-mode
    python-mode
    python-docstring
    rust-mode
    sass-mode
    scss-mode
    yaml-mode

    all-the-icons
    discover-my-major
    eyebrowse
    expand-region
    google-maps
    google-this
    google-translate
    magit
    magit-gitflow
    magit-org-todos
    magit-popup
    git-commit
    neotree
    org
    org-autolist
    ox-gfm
    w3m)
  "A list of packages to ensure are installed at launch.")

(defun mmb-packages-installed-p ()
  (loop for p in mmb-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (mmb-packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p mmb-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'mmb-packages)
