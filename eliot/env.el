;; Start server add some custom directories with elisp
(server-start)

(if (eq system-type 'windows-nt)
    (progn
      (setq system-org-agenda-files
            (quote ("~/Dropbox/org/todo.org"
                    "~/Dropbox/org/cq_todo.org"
                    ;;"~/Dropbox/org/justag.org"
                    "~/Dropbox/org/emacs.org"
                    "~/Dropbox/org/freelance.org")))
      (setq twittering-curl-program "~/.emacs.d/elisp/twittering-mode/win-curl/curl.exe") ;; Trouble finding curl/openssl before, specifying fixed issue
      ;;(setq twittering-cert-file
                                        ;"~/.emacs.d/elisp/twittering-mode/win-curl/equifax.cer")
      )
  )

;; Enable only for Mac right now
(if (eq system-type 'darwin)
    (progn
      (setq system-org-agenda-files
            (quote ("~/Dropbox/org/todo.org"
                    ;;"~/Dropbox/org/justag.org"
                    ;;"~/Dropbox/org/cq_todo.org"
                    ;;"~/Dropbox/org/temp_justag.org"
                    "~/Dropbox/org/emacs.org"
                    "~/Dropbox/org/freelance.org"
                    "~/Dropbox/org/refile.org")))
      (add-to-list 'load-path "~/.emacs.d/erlang")
      ;; Configuration for Erlang mode
      ;; (require 'erlang-mode-config)
      (setq mac-command-modifier 'meta) ;; Sets the command (Apple) key as Meta
      (setq mac-option-modifier 'alt) ;; Sets the Option key as Command
      ;;(tool-bar-mode nil)
      (let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))
      ;; (setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH")))
      (setenv "PYTHON" "/opt/local/bin/python2.7")
      ))

;; Not ready for evil right now haha
;; (add-to-list 'load-path "~/.emacs.d/elisp/evil")
;; (require 'evil)
;; (evil-mode 1)

;; (provide 'eliot-env)
