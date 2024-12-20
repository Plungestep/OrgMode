;; Set the default frame size
(add-to-list 'default-frame-alist '(width . 100))  ;; Width in characters
(add-to-list 'default-frame-alist '(height . 50))  ;; Height in characters

;; Alternatively, set size in pixels
;; (add-to-list 'default-frame-alist '(width-pixel . 1200))
;; (add-to-list 'default-frame-alist '(height-pixel . 800))

;; Load custom settings from a separate file
(setq custom-file "~/.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
