;; Disable the menu bar
(menu-bar-mode -1)

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bar
(scroll-bar-mode -1)

;; Disable the bell sound
(setq ring-bell-function 'ignore)

;; Disable autosave
(setq auto-save-default nil)

;; Store customizations in a separate file
(setq custom-file "~/.emacs.d/custom.el")

;; Load the custom file, but only if it exists
(when (file-exists-p custom-file)
  (load custom-file))

;; Set default frame size
(add-to-list 'default-frame-alist '(width . 80))
(add-to-list 'default-frame-alist '(height . 24))

;; Disable backups
(setq make-backup-files nil)

