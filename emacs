(require 'package)

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
  'dockerfile-mode
  'ensime
  'evil
  'evil-magit
  'haskell-mode
  'helm
  'helm-projectile
  'hindent
  'iedit
  'magit
  'markdown-mode
  'powerline
  'projectile
  'rainbow-delimiters
  'solarized-theme
  'xterm-color
  'yaml-mode
  'intero
  )

; ENV
(setenv "PAGER" "less -X")
;(setenv "TERM" "xterm-256color")

; Disable TABS
(setq-default indent-tabs-mode nil)

; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

; Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; Disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)

; Disable menus
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode -1)
(tool-bar-mode -1)

; Disable startup screen
(setq inhibit-startup-screen t)

; Window settings
(setq window-min-width 64)

; Follow symlinks
(setq vc-follow-symlinks t)

; Case sensitive tags search
(setq tags-case-fold-search nil)


; EVIL
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode t)

; Magit
(require 'evil-magit)
(global-set-key (kbd "C-c g") 'magit-status)

; Powerline
(require 'powerline)
(powerline-center-evil-theme)

; Projectile
(require 'projectile)
(projectile-mode t)
(global-set-key [f1] 'projectile-run-eshell)

; Helm
(require 'helm)
(helm-mode t)
(global-set-key [f2] 'helm-projectile)

(global-set-key [f3] (lambda (&rest args)
    (interactive)
    (cd (projectile-project-root))
    (helm-grep-do-git-grep args)
  ))

(global-set-key [f4] 'helm-etags-select)


; Haskell

(require 'intero)
(require 'flycheck)

(define-key intero-mode-map (kbd "C-c C-o") 'haskell-mode-format-imports)

(add-hook 'haskell-mode-hook 'intero-mode)
(add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)
(flycheck-add-next-checker 'intero '(warning . haskell-hlint))


;;; (setq haskell-process-type 'stack-ghci)
;;; (setq haskell-compile-cabal-build-command "stack build")
;;;
;;; (require 'haskell-mode)
;;; (require 'rainbow-delimiters)
;;; (require 'hindent)
;;;
;;; (add-hook 'haskell-mode-hook #'hindent-mode)
;;; (add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)
;;;
;;; (add-to-list 'interpreter-mode-alist '("stack" . haskell-mode))
;;;
;;; (eval-after-load "haskell-mode" '(progn
;;;   (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
;;;   (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-mode-format-imports)
;;;   ))
;;; (eval-after-load "haskell-cabal"
;;;     '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
;;;

; C++
(setq-default c-basic-offset 2)
(add-hook 'c++-mode-hook
  (function (lambda () (setq evil-shift-width c-basic-offset)
                       (modify-syntax-entry ?_ "w") )))

; Arduino
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

; Markdown
(require 'markdown-mode)

; YAML
(require 'yaml-mode)

; Docker
(require 'dockerfile-mode)

; Solarized
(load-theme 'solarized-light t)

; Shell
(require 'xterm-color)
(progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
       (setq font-lock-unfontify-region-function 'xterm-color-unfontify-region))


; Frame title format
(setq frame-title-format '("%b"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(package-selected-packages
   (quote
    (dockerfile-mode evil-magit solarized-theme rainbow-delimiters powerline magit iedit helm-projectile haskell-mode evil-visual-mark-mode ensime)))
 '(safe-local-variable-values
   (quote
    ((intero-targets "amazonka-core:lib" "amazonka-core:test:tests")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
