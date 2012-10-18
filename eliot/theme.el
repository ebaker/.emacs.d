;;(require 'color-theme)
(require 'color-theme-ir-black)
(require 'color-theme-subdued)
;;(require 'color-theme-tango)
;;(require 'dark-emacs)

;; Font and colorscheme  settings based on system

(defun windows-theme-settings ()
  "Setup windows fonts and themes for environment."
  (color-theme-subdued)
  (set-face-font 'default "-outline-Consolas-normal-r-normal-normal-*-*-96-96-c-*-iso8859-1")
  (set-face-font 'bold "-outline-Consolas-bold-r-normal-normal-*-*-96-96-c-*-iso8859-1")
  (set-face-font 'italic "-outline-Consolas-normal-i-normal-normal-*-*-96-96-c-*-iso8859-1")
  (set-face-font 'bold-italic "-outline-Consolas-bold-i-normal-normal-*-*-96-96-c-*-iso8859-1")
  )

(defun darwin-theme-settings ()
  "Setup darwin fonts and theme for environment."
  (color-theme-ir-black)
  (set-default-font "-apple-Inconsolata-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1"))

;; Check system and apply settings
(if (eq system-type 'windows-nt)
    (windows-theme-settings))
(if (eq system-type 'darwin)
    (darwin-theme-settings))

;; Set font sizs for windows - old
;; (set-face-attribute 'default nil :height 100)
;; (set-face-attribute 'bold nil :height 100)
;; (set-face-attribute 'italic nil :height 100)
;; (set-face-attribute 'bold-italic nil :height 100)

