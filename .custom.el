;;; Org Mode Configuration

;; Package initialization should come first
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Setup use-package first
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Install and configure org-super-agenda
(use-package org-super-agenda
  :ensure t
  :config
  (org-super-agenda-mode))

;; Org mode configuration
(use-package org
  :pin gnu
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("<f4>"  . org-agenda))
  :config
  (setq org-hide-emphasis-markers t
        org-log-done 'time
        org-return-follows-link t)

  (setq org-todo-keywords
        '((sequence "STARTED(d)" "TODO(t)" "NEXT(n)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")))

  (setq org-todo-keyword-faces
        '(("TODO"      :foreground "red"          :weight bold)
          ("STARTED"   :foreground "blue"         :weight bold)
          ("NEXT"      :foreground "royal blue"   :weight bold)
          ("DONE"      :foreground "forest green" :weight bold)
          ("WAITING"   :foreground "orange"       :weight bold)
          ("SOMEDAY"   :foreground "magenta"      :weight bold)
          ("CANCELLED" :foreground "forest green" :weight bold)))

  ;; Hooks
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'visual-line-mode)

  ;; Tags configuration
  (setq org-tag-alist '(("PHONE" . ?p)
                       ("COMPUTER" . ?c)
                       ("SHOPPING" . ?s)
                       ("FAMILY" . ?f)
                       ("URGENT" . ?u)
                       ("IMPORTANT" . ?i))))

;; File associations
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; Install and configure org-bullets
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/Users/kris.fredrick/Nextcloud/Notes/Org Mode/tasks.org"))
 '(package-selected-packages '(org-bullets org-super-agenda)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
