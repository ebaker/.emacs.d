(add-to-list 'load-path "~/.emacs.d/vendor")

(setq custom-file "~/.emacs.d/eliot/custom.el")
(load custom-file 'noerror)

;; eliot custom scripts
(load "eliot/env" )
(load "eliot/js")
(load "eliot/org" )
(load "eliot/autocomplete")
;;(load "eliot/python")
(load "eliot/gnus")

(load "eliot/eshell")
(load "eliot/defuns")
;; (load "eliot/flymake")
(load "eliot/php")
(load "eliot/theme")
(load "eliot/escreen")
;; (load "eliot/gnus")
(load "eliot/network")
