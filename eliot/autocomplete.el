;; (add-to-list 'load-path "~/.emacs.d/elisp/smart-tab")
;; (require 'smart-tab)

;; (setq smart-tab-completion-functions-alist
;;       '((emacs-lisp-mode . lisp-complete-symbol)
;;         (text-mode . dabbrev-completion)))

;; (setq smart-tab-disabled-major-modes
;;       '(org-mode term-mode inferior-python-mode rcirc-mode))

;; (setq hippie-expand-try-functions-list
;;       '(yas/hippie-try-expand
;;         try-expand-dabbrev
;;         try-expand-dabbrev-all-buffers
;;         try-expand-dabbrev-from-kill
;;         try-complete-file-name
;;         try-complete-lisp-symbol))

;; (setq smart-tab-using-hippie-expand t)

;; (global-smart-tab-mode 1)
(add-to-list 'load-path "~/.emacs.d/elisp/popup-el")
(require 'popup)

(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete") ; This may
                                        ; not be appeared if you have
                                        ; already added.
(require 'auto-complete)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/dict" )
(defun ac-common-setup ()
  (add-to-list 'ac-sources 'ac-source-filename
               ;;'ac-source-yasnippet
               ))
(ac-config-default)

;; http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
;;(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")
;;(require 'yasnippet)
;;(setq yas/root-directory "~/.emacs.d/elisp/yasnippet/snippets")
;;(yas/initialize)
;; (yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets")
;; Let's have snippets in the auto-complete dropdown
(add-to-list 'ac-sources 'ac-source-yasnippet)

;; ;; Yasnippet autocomplete START
;; (add-to-list 'load-path "~/.emacs.d/elisp/yasnippet") ; This may not be appeared if you have already added.
;; (require 'yasnippet)      ;; Use the newer yasnippet
;; (setq yas/root-directory "~/.emacs.d/elisp/yasnippet/snippets")
;; (yas/initialize)
;; (setq yas/prompt-functions '(yas/dropdown-prompt))
;; (setq yas/wrap-around-region t)
;; ;; Yasnippet autocomplete END
(require 'dropdown-list)
(require 'yasnippet)      ;; Use the newer yasnippet

(yas/global-mode 1)

(yas/load-directory "~/.emacs.d/snippets")

(setq yas/prompt-functions '(yas/ido-prompt
                             yas/dropdown-prompt
                             yas/completing-prompt))

;; Auto Syntax Error Hightlight
;; (when (load "flymake" t)
;;     (defun flymake-pyflakes-init ()
;;           (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;        (local-file (file-relative-name
;;             temp-file
;;             (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;       (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))
;; ;(add-hook 'find-file-hook 'flymake-find-file-hook)
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (unless (eq buffer-file-name nil) (flymake-mode 1)) ;dont invoke flymake on temporary buffers for the interpreter
;;             (local-set-key [f2] 'flymake-goto-prev-error)
;;             (local-set-key [f3] 'flymake-goto-next-error)
;;             ))

;; '(flymake-errline ((((class color)) (:background "violet" :foreground "black"))))
;; '(flymake-warnline ((((class color)) (:background "LightBlue2" :foreground "black"))))

;; (setq python-python-commmand "/opt/local/bin/python2.7") 

