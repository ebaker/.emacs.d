;; PHP Configs
(require 'php-mode)
;; To use abbrev-mode, add lines like this:
(add-hook 'php-mode-hook
          '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))

;; (add-to-list 'load-path "~/.emacs.d/php/geben")
;; (require 'geben)

;; (add-hook 'php-mode-hook (lambda() (flymake-mode 1)))
;; (define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
;; (define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

;; nXhtml to play nice with multiple languages
(load "~/.emacs.d/vendor/nxhtml/autostart.el")
;; (setq mumamo-chunk-coloring 'no-chunks-colored)



;; Mumamo is making emacs 23.3 freak out:
;; http://stackoverflow.com/questions/5468952/how-do-i-hide-emacs-obsolete-variable-warnings/5470584#5470584
(when (and (equal emacs-major-version 24)
           (equal emacs-minor-version 2))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-syntactic-keywords))
  ;; tramp-compat.el clobbers this variable!
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function)))
