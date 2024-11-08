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

(setq default-frame-alist '((undecorated . t)))

;; Set frame size
(add-hook 'after-make-frame-functions
          (lambda (frame)
	    (set-frame-size frame 80 24)
	    (scroll-bar-mode -1)))


;; disable window decorations
(set-frame-parameter nil 'undecorated t)

;; Disable backups
(setq make-backup-files nil)

;; Zoom with mouse scroll
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;; Org
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c o") (lambda () (interactive) (cd "~/org") (call-interactively 'find-file)))

(setq org-agenda-files '("~/org/personal.org" "~/org/bisc.org"))
(setq org-startup-indented t)

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)" "CANCELED(c)")))

(with-eval-after-load 'org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0)))

(setq org-capture-templates
      '(("t" "Todo (Personal)" entry (file+headline "~/org/personal.org" "Tasks")
         "* TODO %?\n")
      ("e" "Event (Personal)" entry (file+headline "~/org/personal.org" "Events")
       "* %?\n %^{Scheduled to begin}t")
      ("T" "Todo (BISC)" entry (file+headline "~/org/bisc.org" "Tasks")
         "* TODO %?\n DEADLINE: %^{Deadline}t")
      ("E" "Event (BISC)" entry (file+headline "~/org/bisc.org" "Events")
         "* %?\n %^{Scheduled to begin}t")))

(add-hook 'org-after-todo-state-change-hook
      (lambda ()
        (save-some-buffers t (lambda () (eq major-mode 'org-mode)))))

;; Set TEST task in red in agenda view
(defface org-agenda-test-face
  '((t (:foreground "#ff6666" :weight bold)))
  "Face for tasks labeled with 'TEST'.")

(defun org-agenda-highlight-test-tasks ()
  "Highlight tasks that start with 'TEST' in red."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^\\(.*\\)TEST" nil t)
      (add-text-properties (match-beginning 1) (line-end-position)
                           '(face org-agenda-test-face)))))

(add-hook 'org-agenda-finalize-hook 'org-agenda-highlight-test-tasks)

;; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)))

;;(setq org-babel-python-command "python3")

(setq org-babel-default-header-args:python
      '((:session . "default") (:results . "output")))

(setq org-confirm-babel-evaluate nil) ; don't ask for confirmation before running block
;; (setq org-babel-python-command "ipython --no-banner --classic --no-confirm-exit")

;;;; Packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Theme
(use-package monokai-theme)
(load-theme 'monokai t)

;; which-key
(use-package which-key
  :init
  (setq which-key-idle-delay 0.1)
  :config
  (which-key-mode t))

;; dired-sidebar
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :init
  (setq dired-sidebar-subtree-line-prefix "   ")
  (setq dired-sidebar-theme 'vscode) ; possible themes: 'nerd, 'vscode, 'icons
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))


(setq byte-compile-warnings '(not docstrings))
(use-package vscode-icon
  :ensure t
  :commands (vscode-icon-for-file))

;; Magit
(use-package magit
  :config
  (setq magit-define-global-key-bindings 'recommended))

;; ace-window
(use-package ace-window)
(global-set-key (kbd "M-o") 'ace-window)


;; ace-jump-mode
(use-package ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; jump back
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; eglot
(defun ych-eglot-format-on-save ()
    "Format with eglot before save"
    (add-hook 'before-save-hook 'eglot-format))

(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'ych-eglot-format-on-save)

;; pyvenv
(use-package pyvenv)
(setenv "WORKON_HOME" "~/.cache/pypoetry/virtualenvs")
(pyvenv-mode t)
 
;; corfu
(use-package corfu)
(global-corfu-mode t)

