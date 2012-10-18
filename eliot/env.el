;; Start server add some custom directories with elisp
(server-start)

(if (eq system-type 'windows-nt)
    (setq system-org-agenda-files
          (quote ("~/Dropbox/org/todo.org"
                  "~/Dropbox/org/cq_todo.org"
                  ;;"~/Dropbox/org/justag.org"
                  "~/Dropbox/org/emacs.org"
                  "~/Dropbox/org/freelance.org"))))

;; Enable only for Mac right now
(if (eq system-type 'darwin)
    (progn
      (setq system-org-agenda-files
            (quote ("~/Dropbox/org/todo.org"
                    ;;"~/Dropbox/org/justag.org"
                    ;;"~/Dropbox/org/cq_todo.org"
                    ;;"~/Dropbox/org/temp_justag.org"
                    "~/Dropbox/org/emacs.org"
                    "~/Dropbox/org/freelance.org")))
      (add-to-list 'load-path "~/.emacs.d/erlang")
      ;; Configuration for Erlang mode
      ;; (require 'erlang-mode-config)
      (setq mac-command-modifier 'meta) ;; Sets the command (Apple) key as Meta
      (setq mac-option-modifier 'alt) ;; Sets the Option key as Command
      ;;(tool-bar-mode nil)
      (setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH")))
      (setenv "PYTHON" "/opt/local/bin/python2.7")
      ))

;; Not ready for evil right now haha
;; (add-to-list 'load-path "~/.emacs.d/elisp/evil")
;; (require 'evil)
;; (evil-mode 1)

;; (provide 'eliot-env)
