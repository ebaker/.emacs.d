;; EShell config

;; To make eshell understand .pl perl extensions.
(add-hook 'eshell-named-command-hook 'n-eshell-exec-perl)
(defun n-eshell-exec-perl (command args)
  "04Dec2001 - sailor, to make eshell understand perl scripts."
  (if (string-match "^.+\.pl[ \t]*" command)
      (progn
        (setq args (cons command args))
        (setq args (cons "-S" args))
        (throw 'eshell-replace-command
               (eshell-parse-command "perl" args))
        )
    )
  )

;; Clear eshell buffer
(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; (add-hook 'eshell-mode-hook
;;    '(lambda nil
;;    (eshell/export "EPOCROOT=\\Paragon\\")
;;    (let ((path))
;;            ;;(setq path ".;%PATH%")
;;      (setq path ".;c:/Users/ebaker/bin")
;;      (setq path (concat path ";c:/Program Files (x86)/git/bin;C:/Program Files/Mercurial"))
;; ;;      (setq path (concat path ";d:/program files/microsoft visual studio/vc98/bin"))
;;     (setenv "PATH" path))
;;    (local-set-key "\C-u" 'eshell-kill-input))
;;    )
