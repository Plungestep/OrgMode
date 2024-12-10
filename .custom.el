;;; Org Mode Configuration

;; Basic Setup
(require 'org)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; Visual Enhancements
(setq org-hide-emphasis-markers t)  ; Hide markup symbols for bold, italic, etc.

;; Replace list markers with bullets
(font-lock-add-keywords 'org-mode
                       '(("^ +\\([-*]\\) "
                          (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Key Bindings
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "<f4>")  #'org-agenda)  ; Redundant, but might be useful

;; TODO Keywords Configuration
(setq org-todo-keywords
      '((sequence "STARTED(d)" "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("TODO"      :foreground "red"          :weight bold)
        ("STARTED"   :foreground "blue"         :weight bold)
        ("DONE"      :foreground "forest green" :weight bold)
        ("WAITING"   :foreground "orange"       :weight bold)
        ("SOMEDAY"   :foreground "magenta"      :weight bold)
        ("CANCELLED" :foreground "forest green" :weight bold)
        ("NEXT"      :foreground "purple"       :weight bold)))
