;;; Org Mode Configuration

;; Package initialization should come first
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

;; Sane default settings
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(setq use-file-dialog nil)   ;; No file dialog
(setq use-dialog-box nil)    ;; No dialog box
(setq pop-up-windows nil)    ;; No popup windows

;; Tell emacs to put backups in the trash directory
(setq backup-directory-alist '((".*" . "~/Nextcloud/org/Trash")))

;; Start with dashboard
(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/images/dtmacs-logo.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

;; Setup use-package first
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Targets for refiling include the task file, 9 levels deep.
(setq org-refile-targets '(("~/Nextcloud/org/tasks.org" :maxlevel . 9)))

;; Specify the file for any archives.
(setq org-archive-location "~/Nextcloud/org/archive.org::* From %s")

;; Set my files to be used with the agenda view
(setq org-agenda-files '("~/Nextcloud/org/tasks.org" "~/Nextcloud/org/refile.org"))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

; Use the current window when visiting files and buffers with IDO
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;; Turn on LOGFILE in tasks
(setq org-log-into-drawer t)
(setq org-clock-into-drawer t)

;; Enable global auto-revert
(global-auto-revert-mode 1)
(setq auto-revert-interval 1)

;; Set default file
(setq org-directory "~/Nextcloud/org")
(setq org-default-notes-file "~/Nextcloud/org/refile.org")

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

;; Set up my templates for quick capture
(setq org-capture-templates
      '(("t" "todo" entry (file "~/Nextcloud/org/refile.org")
         "* TODO %?\n:LOGBOOK:\n- State \"TODO\" from %U\n:END:\n%a\n")
        ("n" "note" entry (file "~/Nextcloud/org/refile.org")
         "* %? :NOTE:\n:LOGBOOK:\n- Note created on %U\n:END:\n%a\n")
        ("j" "journal" entry (file+datetree "~/Nextcloud/org/journal.org")
         "* %?\n:LOGBOOK:\n- Created on %U\n:END:\n")))

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
        '((sequence "TODO(t@/!)" "NEXT(n/!)" "STARTED(r/!)" "WAITING(w@/!)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c@)")))

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
 '(org-agenda-files '("~/Nextcloud/org/tasks.org" "~/Nextcloud/org/refile.org"))
 '(package-selected-packages '(org-modern spacemacs-theme org-bullets org-super-agenda)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:height 1.0))))
 '(org-level-2 ((t (:height 1.0 :weight normal)))))
