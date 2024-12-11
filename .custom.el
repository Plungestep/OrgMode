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

;; Enable global auto-revert
(global-auto-revert-mode 1)
(setq auto-revert-interval 1)

;; Use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Install and configure spacemacs-theme
(use-package spacemacs-theme
  :ensure t
  :config
  (load-theme 'spacemacs-light t))

;; Install and configure org-super-agenda
(use-package org-super-agenda
  :ensure t
  :config
  (org-super-agenda-mode))

;; Improve org mode looks
(setq-default org-startup-indented t
              org-pretty-entities t
              org-use-sub-superscripts "{}"
              org-hide-emphasis-markers t
              org-startup-with-inline-images t
              org-image-actual-width '(300))

;; Remove the time grid in agenda
(setq org-agenda-use-time-grid nil)

;; Enable follow mode in agenda automatically
(setq org-agenda-start-with-follow-mode t)

;; Setup a process for quick capture entries
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
         "* %?\n  %i\n  %a")))

;; Install and configure org-modern
(use-package org-modern
  :hook
  (org-mode . global-org-modern-mode)
  :custom
  (org-modern-keyword nil)
  (org-modern-checkbox nil)
  (org-modern-table nil)
  (org-modern-tag t)  ; Enable modern tag styling
  (org-modern-tag-align t)  ; Enable tag alignment
  (org-modern-todo-faces
   '(("TODO"      :background "orange"       :foreground "black" :weight bold)
     ("STARTED"   :background "blue"         :foreground "white" :weight bold)
     ("NEXT"      :background "royal blue"   :foreground "white" :weight bold)
     ("DONE"      :background "forest green" :foreground "white" :weight bold)
     ("WAITING"   :background "gray"         :foreground "white" :weight bold)
     ("SOMEDAY"   :background "magenta"      :foreground "white" :weight bold)
     ("CANCELLED" :background "forest green" :foreground "white" :weight bold))))

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

  ;; Custom heading sizes and styles
  (custom-set-faces
   '(org-level-1 ((t (:height 1.0))))
   '(org-level-2 ((t (:height 1.0 :weight normal))))  ; Made level 2 not bold
  )

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
   '("/Users/kris.fredrick/Nextcloud/Tasks/tasks.org"))
 '(package-selected-packages '(org-modern spacemacs-theme org-bullets org-super-agenda)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
