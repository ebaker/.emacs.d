;;(add-to-list 'load-path "~/.emacs.d/elisp/python-mode")
;;(setq py-install-directory "~/.emacs.d/elisp/python-mode")
;;(require 'python-mode)(require 'python-mode)

;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))



;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;;(setq py-python-command-args '("-pylab" "-colors" "LightBG"))


;; fgallina/python.el
;; (require 'python (concat epy-install-dir "extensions/python.el"))
(add-to-list 'load-path "~/.emacs.d/elisp/python.el")
(require 'python)

(defun setup_ipython ()
  (require 'ipython)
  (setq ipython-command "/opt/local/bin/ipython-2.7")
  ;;(require 'ipython)
  (setq py-shell-name "ipython-2.7")
  (setq py-python-command "/opt/local/bin/ipython-2.7")
  )

(defun setup_pymacs_ropemacs ()
  "Setup default pymacs config"
  ;; pymacs
  (add-to-list 'load-path "~/.emacs.d/elisp/Pymacs")
  (require 'pymacs)
  ;;(require 'pymacs (concat epy-install-dir "extensions/pymacs.el"))
  (autoload 'pymacs-apply "pymacs")
  (autoload 'pymacs-call "pymacs")
  (autoload 'pymacs-eval "pymacs" nil t)
  (autoload 'pymacs-exec "pymacs" nil t)
  (autoload 'pymacs-load "pymacs" nil t)
  (autoload 'pymacs-autoload "pymacs")
  
  (pymacs-load "ropemacs" "rope-")
  (setq ropemacs-codeassist-maxfixes 5
        ropemacs-guess-project t
        ropemacs-enable-autoimport t
        ropemacs-completing-read-function 'completing-read)
  )

;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;;(pymacs-load "ropemacs" "rope-")
;;(setq ropemacs-enable-autoimport t)

;; (defun setup-ropemacs ()
;;   "Setup the ropemacs harness"
;;   (setenv "PYTHONPATH"
;;           (concat
;;            (getenv "PYTHONPATH") path-separator
;;            "~/.emacs.d/elisp"))
;;   (pymacs-load "ropemacs" "rope-")
  
;;   ;; Stops from erroring if there's a syntax err
;;   (setq ropemacs-codeassist-maxfixes 3)

;;   ;; Configurations
;;   (setq ropemacs-guess-project t)
;;   (setq ropemacs-enable-autoimport t)


;;   (setq ropemacs-autoimport-modules '("os" "shutil" "sys" "logging"
;; 				      ;;"django.*"
;;                                       ))
;; ;; Adding hook to automatically open a rope project if there is one
;;   ;; in the current or in the upper level directory
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (cond ((file-exists-p ".ropeproject")
;;                      (rope-open-project default-directory))
;;                     ((file-exists-p "../.ropeproject")
;;                      (rope-open-project (concat default-directory "..")))
;;                     )))
;;   )

;; However, to make it working in emacs, you will have to add this line to your .emacs, the full patch for ipython.el is at https://github.com/ipython/ipython/issues/issue/204

;; (setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")
;; (require 'ipython)

;; Ipython integration with fgallina/python.el
(defun setup-ipython ()
  "Setup ipython integration with python-mode"
  (interactive)
  (setq
   python-shell-interpreter "ipython-2.7"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \[[0-9]+\]: "
   python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
   python-shell-completion-setup-code ""
   python-shell-completion-string-code "';'.join(__IP.complete('''%s'''))\n")
  )

;;(add-to-list 'load-path "~/.emacs.d/elisp/helm")
;;(add-to-list 'load-path "~/.emacs.d/elisp/helm-ipython.el")
;;(require 'helm-config)
;;(require 'helm-ipython)
;;(when (require 'helm-show-completion nil t)
;;(use-helm-show-completion 'helm-ipython-complete '(length
;;initial-pattern)))

;; (require 'anything)
;; (require 'anything-ipython)
;; (when (require 'anything-show-completion nil t) (use-anything-show-completion 'anything-ipython-complete '(length initial-pattern)))



(defun try-complete-ropemacs (old)
  (save-excursion
    (unless old
      (he-init-string (he-dabbrev-beg) (point))
      (when (not (equal he-search-string ""))
        (setq he-expand-list
              (sort (all-completions
                     he-search-string
                     (delete-duplicates
                      (mapcar
                       (lambda (completion)
                         (concat he-search-string
                                 (replace-regexp-in-string
                                  "^[\r\n\t ]+\\|[\r\n\t ]+$" ""
                                  (nth 0 (split-string completion ":")))))
                       (ignore-errors
                         (rope-completions)))
                      :test 'string=))
                    'string-lessp))))
    (while (and he-expand-list
                (he-string-member (car he-expand-list) he-tried-table))
      (setq he-expand-list (cdr he-expand-list)))
    (if (null he-expand-list)
        (progn (if old (he-reset-string)) ())
      (progn
        (he-substitute-string (car he-expand-list))
        (setq he-tried-table (cons (car he-expand-list)
                                   (cdr he-tried-table)))
        t))))


(remove-hook 'python-mode-hook 'ac-ropemacs-setup)
(setq ac-ropemacs-completions-cache nil)
(setq ac-source-ropemacs
  '((init
     . (lambda ()
         (setq ac-ropemacs-completions-cache
               (delete-duplicates
                (mapcar
                 (lambda (completion)
                   (concat ac-prefix
                           (replace-regexp-in-string
                            "^[\r\n\t ]+\\|[\r\n\t ]+$" ""
                            (nth 0 (split-string completion ":")))))
                 (ignore-errors
                   (rope-completions)))
                :test 'string=))))
    (symbol . "p")
    (candidates . ac-ropemacs-completions-cache)))

(remove-hook 'python-mode-hook 'wisent-python-default-setup)

(require 'flymake)

(defun flymake-python-init ()
  (let* ((process-environment (python-shell-calculate-process-environment))
         (exec-path (python-shell-calculate-exec-path))
         (checker (executable-find "python-check")))
    (when checker
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list checker (list local-file))))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-python-init))

(defun python-flymake-setup ()
  (interactive)
  ;; Do not active when using sudo or in a server
  (when (not (file-remote-p default-directory))
    (flymake-mode 1)
    (flymake-start-syntax-check)
    (local-set-key [S-up]
                   (lambda ()
                     (interactive)
                     (ignore-errors
                       (flymake-goto-prev-error)
                       (message "%s"
                                (flymake-ler-text
                                 (caar (flymake-find-err-info
                                        flymake-err-info
                                        (flymake-current-line-no))))))))
    (local-set-key [S-down]
                   (lambda ()
                     (interactive)
                     (ignore-errors
                       (flymake-goto-next-error)
                       (message "%s"
                                (flymake-ler-text
                                 (caar (flymake-find-err-info
                                        flymake-err-info
                                        (flymake-current-line-no))))))))))

(defadvice flymake-start-syntax-check-process
  (around python-flymake-start-syntax-check-process (cmd args dir))
  "`flymake-start-syntax-check-process' with virtualenv support."
  (if (eq major-mode 'python-mode)
      (let* ((process-environment (python-shell-calculate-process-environment))
             (exec-path (python-shell-calculate-exec-path)))
        ad-do-it)
    ad-do-it))
(ad-activate 'flymake-start-syntax-check-process)

(defun python-setup ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(yas/hippie-try-expand
         try-complete-file-name
         try-complete-ropemacs))
  (setq ac-sources
        '(ac-source-ropemacs ac-source-yasnippet ac-source-filename)))

;; (add-hook 'python-mode-hook 'python-flymake-setup)
(add-hook 'python-mode-hook 'python-setup)
(add-hook 'python-mode-hook 'setup_ipython)
(add-hook 'python-mode-hook 'setup_pymacs_ropemacs)

;; (setq pylookup-dir "~/.emacs.d/elisp/pylookup")
;; (add-to-list 'load-path pylookup-dir)

;; ;; load pylookup when compile time
;; (eval-when-compile (require 'pylookup))

;; ;; set executable file and db file
;; (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
;; (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; ;; set search option if you want
;; ;; (setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))

;; ;; to speedup, just load it on demand
;; (autoload 'pylookup-lookup "pylookup"
;;   "Lookup SEARCH-TERM in the Python HTML indexes." t)

;; (autoload 'pylookup-update "pylookup" 
;;   "Run pylookup-update and create the database at `pylookup-db-file'." t)

(provide 'eliot-python)
