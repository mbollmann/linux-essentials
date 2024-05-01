(require 'cl-lib)

;;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;;; End bootstrap straight.el

;;; Make (use-package ...) commands use straight without explicitly told to
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;; Packages that are not loaded/configured in other files
(straight-use-package 'async)
(straight-use-package 'benchmark-init)
(straight-use-package 'dash)
(straight-use-package 'epl)
(straight-use-package 'let-alist)
(straight-use-package 'pkg-info)
(straight-use-package 'popup)
(straight-use-package 's)
(straight-use-package 'seq)
(straight-use-package 'tabbar)
(straight-use-package 'with-editor)

(straight-use-package 'aas)
(straight-use-package 'anzu)
(straight-use-package 'ess)
(straight-use-package 'yasnippet)

(straight-use-package 'discover-my-major)
(straight-use-package 'git-commit)
(straight-use-package 'ox-gfm)

(provide 'mmb-packages)
