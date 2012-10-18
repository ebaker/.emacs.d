(require 'flymake)

;; PHP Windows flymake configuration

(defvar phpwin-php.exe-location "c:\\Progra~2\\PHP\\php.exe"
  "Location for the PHP.exe executable on windows.")

(defun phpwin-flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
    This is a replacement for `flymake-create-temp-inplace'. The
    difference is that it gives a file name in
    `temporary-file-directory' instead of the same directory as
    FILE-NAME.

    For the use of PREFIX see that function.

    This won't always work; it will fail if the source module
    refers to relative paths.
    "
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))


(defun phpwin-flymake-get-cmdline  (source base-dir)
  "Gets the cmd line for running a flymake session in a PHP buffer.
    This gets called by flymake itself."
  (list phpwin-php.exe-location (list "-f" source  "-l")))

(defun phpwin-flymake-init ()
  "initialize flymake for php"
  (let ((create-temp-f 'phpwin-flymake-create-temp-intemp)
        ;;(create-temp-f 'flymake-create-temp-inplace)
        (use-relative-base-dir t)
        (use-relative-source t)
        (get-cmdline-f 'phpwin-flymake-get-cmdline)
        args
        temp-source-file-name)

    (setq temp-source-file-name (flymake-init-create-temp-buffer-copy create-temp-f)

          args (flymake-get-syntax-check-program-args
                temp-source-file-name "."
                use-relative-base-dir use-relative-source
                get-cmdline-f))
    args))

(defun phpwin-flymake-cleanup () )

;; Original Flymake erlang config
(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "~/.emacs.d/flymake/bin/eflymake" (list local-file))))


(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "tidy" (list local-file))))



(defun flymake-xml-init ())

(eval-after-load "flymake"
  '(progn
     ;; PHP Windows File Hook
     (let* ((key "\\.php\\'")
            (phpentry (assoc key flymake-allowed-file-name-masks)))
       (if phpentry
           (setcdr phpentry '(phpwin-flymake-init phpwin-flymake-cleanup))
         (add-to-list
          'flymake-allowed-file-name-masks
          (list key 'phpwin-flymake-init 'phpwin-flymake-cleanup))))
     ))

(eval-after-load "flymake"
  '(progn
     ;; XML File Hook
     (add-to-list 'flymake-allowed-file-name-masks '("\\.xml\\'" flymake-xml-init))
     ;; Erlang File Hook
     (add-to-list 'flymake-allowed-file-name-masks
             '("\\.erl\\'" flymake-erlang-init))
     (add-hook 'find-file-hook 'flymake-find-file-hook)
     ;; HTML File Hook
     (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.html$\\|\\.ctp" flymake-html-init))
     (add-to-list 'flymake-err-line-patterns
             '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
               nil 1 2 4))
     ))


;; (defun flymake-php-init ()
;;   "Use php to check the syntax of the current file."
;;   (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;;       (local (file-relative-name temp (file-name-directory buffer-file-name))))
;;     (list "php" (list "-f" local "-l"))))

;; (add-to-list 'flymake-err-line-patterns
;;   '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

;; (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; ;; Drupal-type extensions
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.module$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.install$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.inc$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.engine$" flymake-php-init))

;; (add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
;; (define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
;; (define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

;; HTML Mode config from http://www.emacswiki.org/emacs/FlymakeHtml
;; (delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
;;(delete '("\\.xml?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;; flyspell setup
;; (setq ispell-program-name "aspell")
;; (setq ispell-dictionary "english")

;; http://trey-jackson.blogspot.com/2008/04/emacs-tip-16-flyspell-and-flyspell-prog.html
;; (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;; (add-hook 'message-mode-hook 'turn-on-flyspell)
;; (add-hook 'text-mode-hook 'turn-on-flyspell)
;; (add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;; (add-hook 'tcl-mode-hook 'flyspell-prog-mode)
;; (defun turn-on-flyspell ()
;;    "Force flyspell-mode on using a positive arg.  For use in hooks."
;;    (interactive)
;;    (flyspell-mode 1))


(provide 'eliot-flymake)
