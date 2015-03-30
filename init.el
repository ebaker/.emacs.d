;; Dropbox for .emacs.d?
;; (setq dotfiles-dir "~/Dropbox/.emacs.d/")


;; Based on emacs starter kit as those are the first required packages
(require 'package)
(dolist (source '(("gnu" . "http://elpa.gnu.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      starter-kit-js
                      color-theme
                      org
                      evil
                      php-mode
                      jabber
                      yasnippet
                      twittering-mode
                      auto-complete
                      color-theme-ir-black
                      ;; color-theme-tango
                      ;; color-theme-gruber-darker
                      escreen
                      ;; evil
                      js-comint
                      js2-mode
                      ;; hexrgb
                      popup
                      ;; multi-eshell
                      epg
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d")
(load "eliot" )

(put 'dired-find-alternate-file 'disabled nil)
