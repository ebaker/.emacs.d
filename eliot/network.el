(require 'tls)


;; adjust this path:
;; (add-to-list 'load-path "~/.emacs.d/elisp/emacs-jabber")
;; For 0.7.90 and above:
(require 'jabber-autoloads)

;; Tramp settings found at https://github.com/mattkeller/elisp
(require 'tramp)
(setq tramp-default-method "ssh")
;; (setq tramp-default-user user-login-name)
(setq tramp-auto-save-directory "~/.tramp/autosave")
;; speed things up by using backup dir, still could use work
(setq tramp-bkup-backup-directory-info (list "." "~/.tramp/backups/" 'full-path))
;; (require 'backup-dir)
;; (setq tramp-bkup-backup-directory-info bkup-backup-directory-info)

;; Twittering Mode Init
;; (add-to-list 'load-path "~/.emacs.d/elisp/twittering-mode")
(require 'twittering-mode)


;; (require 'epa-file)
;; (epa-file-enable)
;; Needs gpg and easygpg setup
(setq twittering-use-master-password t) ; To avoid having to authorize twittering-mode everytime you run it

(setq twittering-icon-mode t)                ; Show icons
(setq twittering-timer-interval 300)         ; Update your timeline each 300 seconds (5 minutes)
(setq twittering-url-show-status nil)        ; Keeps the echo area from showing all the http processes


;; Twittering mode custom keybindings
(add-hook 'twittering-mode-hook
          (lambda ()
            (mapc (lambda (pair)
                    (let ((key (car pair))
                          (func (cdr pair)))
                      (define-key twittering-mode-map
                        (read-kbd-macro key) func)))
                  '(("F" . twittering-friends-timeline)
                    ("R" . twittering-replies-timeline)
                    ("U" . twittering-user-timeline)
                    ("W" . twittering-update-status-interactive)))))

(setq twittering-tinyurl-service 'bit.ly)

