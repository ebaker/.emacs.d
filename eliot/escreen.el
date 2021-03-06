;; escreen - http://www.splode.com/~friedman/software/emacs-lisp/#ui
;; http://tapoueh.org/blog/2009/09/22-escreen-integration.html
;; http://blog.nguyenvq.com/2011/03/07/escreen-instead-of-elscreen-for-screen-like-features-in-emacs/

(load "escreen")
(escreen-install)

(setq escreen-prefix-char "\C-z") ;; http://www.macs.hw.ac.uk/~hwloidl/cool-el.html
(global-set-key escreen-prefix-char 'escreen-prefix)
;; (setq escreen-prefix-char [(control ?z)])

;; add C-\ l to list screens with emphase for current one
(defun escreen-get-active-screen-numbers-with-emphasis ()
  "what the name says"
  (interactive)
  (let ((escreens (escreen-get-active-screen-numbers))
        (emphased ""))

    (dolist (s escreens)
      (setq emphased
            (concat emphased (if (= escreen-current-screen-number s)
                                 (propertize (number-to-string s)
                                             ;;'face 'custom-variable-tag) " ")
                                             'face 'info-title-3)
                                             ;;'face 'font-lock-warning-face)
                                             ;;'face 'secondary-selection)
                               (number-to-string s))
                    " ")))
    (message "escreen: active screens: %s" emphased)))

(global-set-key (kbd "C-\\ l") 'escreen-get-active-screen-numbers-with-emphasis)

(defun dim:escreen-goto-last-screen ()
  (interactive)
  (escreen-goto-last-screen)
  (escreen-get-active-screen-numbers-with-emphasis))

(defun dim:escreen-goto-prev-screen (&optional n)
  (interactive "p")
  (escreen-goto-prev-screen n)
  (escreen-get-active-screen-numbers-with-emphasis))

(defun dim:escreen-goto-next-screen (&optional n)
  (interactive "p")
  (escreen-goto-next-screen n)
  (escreen-get-active-screen-numbers-with-emphasis))

(define-key escreen-map escreen-prefix-char 'escreen-goto-last-screen-dim)
 
(defun escreen-create-screen-dim ()
  (interactive)
  (escreen-create-screen)
  (escreen-get-active-screen-numbers-with-emphasis))
 
(defun escreen-kill-screen-dim ()
  (interactive)
  (escreen-kill-screen)
  (escreen-get-active-screen-numbers-with-emphasis))
 
(add-hook 'escreen-goto-screen-hook 'escreen-get-active-screen-numbers-with-emphasis)
 
(define-key escreen-map "c" 'escreen-create-screen-dim)
(define-key escreen-map "k" 'escreen-kill-screen-dim)

(define-key escreen-map escreen-prefix-char 'dim:escreen-goto-last-screen)

(global-set-key (kbd "M-[") 'dim:escreen-goto-prev-screen)
(global-set-key (kbd "M-]") 'dim:escreen-goto-next-screen)

;; Additional settings commented out from
;; http://blog.nguyenvq.com/2011/03/07/
;; escreen-instead-of-elscreen-for-screen-like-features-in-emacs/

;; (global-set-key (kbd "C-]") 'escreen-goto-next-screen)
;; (keyboard-translate ?\C-[ ?\H-[)
;; (global-set-key (kbd "H-[") 'escreen-goto-prev-screen)
;; (global-set-key (kbd "C-]") 'escreen-goto-next-screen-dim)
;; (keyboard-translate ?\C-[ ?\H-[)
;; (global-set-key (kbd "H-[") 'escreen-goto-prev-screen-dim)

;; ElScreen Windows Config
;; (Add-to-list 'load-path "~/.emacs.d/apel")
;; (load "elscreen" "ElScreen" )

;; ;; F9 creates a new elscreen, shift-F9 kills it
;; (global-set-key (kbd "<f9>"    ) 'elscreen-create)
;; (global-set-key (kbd "S-<f9>"  ) 'elscreen-kill)  

;; ;; Windowskey+PgUP/PgDown switches between elscreens
;; (global-set-key (kbd "<s-prior>") 'elscreen-previous) 
;; (global-set-key (kbd "<s-next>")  'elscreen-next)

;; Elscreen Mac Config
;; (setq elscreen-prefix-key "\C-z")
;; ;; Don't display elscreen tab at top
;; (setq elscreen-display-tab nil)
