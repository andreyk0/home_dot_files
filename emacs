(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Extra packages
(ensure-package-installed
  'ensime
  'evil
  'haskell-mode
  'helm
  'helm-projectile
  'hindent
  'iedit
  'magit
  'powerline
  'projectile
  'rainbow-delimiters
  'solarized-theme
  )

(require 'evil)
(evil-mode t)

(require 'powerline)
(powerline-center-evil-theme)

; Disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)

; Disable menus
(menu-bar-mode -1)
(tool-bar-mode -1)

; Disable startup screen
(setq inhibit-startup-screen t)

; Window settings
(setq window-min-width 64)

; Follow symlinks
(setq vc-follow-symlinks t)

; Projectile
(require 'projectile)
(projectile-mode t)

; Helm
(require 'helm)
(helm-mode t)

; Haskell
(require 'haskell-mode)
(require 'hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)
(require 'rainbow-delimiters)
(add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)
(add-to-list 'interpreter-mode-alist '("stack" . haskell-mode))

; Solarized
(load-theme 'solarized-light t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
