;; Disable the menu bar
(menu-bar-mode -1)

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bar
(scroll-bar-mode -1)

;; Disable the bell sound
(setq ring-bell-function 'ignore)

;; Auto-save to disk
(auto-save-visited-mode t) 

;; Store customizations in a separate file
(setq custom-file "~/.emacs.d/custom.el")

;; Load the custom file, but only if it exists
(when (file-exists-p custom-file)
  (load custom-file))

;; Set frame size
(add-hook'after-make-frame-functions
          (lambda (frame) (set-frame-size frame 80 24)))


;; Disable backups
(setq make-backup-files nil)

;; Zoom with mouse scroll
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;; Org
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-agenda-files '("~/org/personal.org" "~/org/bisc.org"))
(setq org-startup-indented t)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/personal.org" "Tasks")
         "* TODO %?\n")
      ("e" "Event" entry (file+headline "~/org/personal.org" "Events")
       "* %^{Event} %^{Scheduled to begin}t %i\n %?")
      ("T" "Todo" entry (file+headline "~/org/bisc.org" "Tasks")
         "* TODO %?\n DEADLINE: %^{Deadline}t")
      ("E" "Event" entry (file+headline "~/org/bisc.org" "Events")
         "* %^{Event} %^{Scheduled to begin}t %i\n %?")))

(add-hook 'org-after-todo-state-change-hook
      (lambda ()
        (save-some-buffers t (lambda () (eq major-mode 'org-mode)))))

;;;; Packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)


;; Python venv
(use-package pet)
(add-hook 'python-base-mode-hook 'pet-mode -10)

;; Theme
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; which-key
(use-package which-key
  :init
  (setq which-key-idle-delay 0.1)
  :config
  (which-key-mode t))
