;;; -*- lexical-binding: t; -*-
;;; Hyper and Super keys → minor mode
;;; I was inspired by the https://protesilaos.com

(defvar-keymap my-emacs-hyper-keys-map
  :doc "My command alternatives using the Hyper key."
  ;; window
  "H-w ]" #'enlarge-window-horizontally
  "H-w [" #'shrink-window-horizontally
  "H-w =" #'balance-windows
  "H-w _" #'shrink-window
  "H-w +" #'enlarge-window
  
  ;; kmacro
  "H-k [" #'kmacro-start-macro
  "H-k ]" #'kmacro-end-macro
  "H-'"    #'kmacro-end-and-call-macro  ; F4
)

(defvar-keymap my-emacs-super-keys-map
  :doc "My command alternatives using the Super key."
  ;; Buffer operations
  "s-b b" #'consult-buffer
  "s-b e" #'eval-buffer
  "s-b n" #'next-buffer
  "s-b p" #'previous-buffer
 ;; Dir operations
  "s-d c"   #'consult-dir
  "s-d d"  #'dired
  ;; Other operations
  "s-g"   #'consult-grep
  "s-z"   #'repeat
;;  "s-;"   #'hippie-expand
  "s-/"   #'undo
  "C-s-/" #'undo-redo
  ;; org-mode    
  "s-o e" #'org-emphasize
  "s-o f" #'org-footnote-action
  "s-o o" #'org-insert-structure-template
  "s-o s" #'org-save-all-org-buffers
  "s-o v" #'org-toggle-inline-images
  ;; my Custom Prefix - 기존 사용하여 익숙했던 것
  "s-t c"  #'select-special-character
  "s-t k"  #'keycast-mode-line-mode
  "s-t m"  #'my-music-player-mode 
  "s-t s"  #'my/search-selected-text
  "s-t v"  #'toggle-my-view-mode
  "s-<return>" #'toggle-frame-fullscreen
)

(define-minor-mode my-emacs-hyper-super-keys-mode
  "Provide Hyper and Super key alternatives to Command."
  :global t
  :init-value t
  :keymap (make-composed-keymap (list my-emacs-hyper-keys-map
                                      my-emacs-super-keys-map)))


;; end here
(provide 'my-emacs-hyper-super-keys)
