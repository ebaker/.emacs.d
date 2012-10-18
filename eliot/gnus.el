;; GMANE is about the only free news server I've seen.
;; I set it to my primary server so I can read a few Free software mailing lists.

(require 'gnus)


;; (setq gnus-select-method
;;       '(nntp "news.gmane.org"))

;; Mostly, though, I just want to read my mail.
;; This setup uses a standard SSL-based connection to read the mail for the accounts I have through
;; UC Berkeley:

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
;;                                   (nnimap-address "imap.gmail.com")
;;                                   (nnimap-server-port 993)
;;                                   (nnimap-stream ssl)))

;;(setq gnus-select-method '(nnimap "gmail"
;;                                (nnimap-address "imap.gmail.com")
;;                                (nnimap-server-port 993)
;;                                (nnimap-stream ssl)))
;;
;;(setq message-send-mail-function 'smtpmail-send-it
;;      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "eliotbaker@gmail.com" nil))
;;      smtpmail-default-smtp-server "smtp.gmail.com"
;;      smtpmail-smtp-server "smtp.gmail.com"
;;      smtpmail-smtp-service 587
;;      ;;smtpmail-local-domain "yourcompany.com"
;;      )

;; Make Gnus NOT ignore [Gmail] mailboxes
;;(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
