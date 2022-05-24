;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Generate with
;;   doom env -o ~/.doom.d/myenv
;; and edit
(doom-load-envvars-file "~/.doom.d/myenv")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Andrey Kartashov"
      user-mail-address "andrey.kartashov@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;;(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'medium))
;; (setq doom-font (font-spec :family "Fira Code" :size 13 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "Fira Code") ; inherits `doom-font''s :size
;;       doom-unicode-font (font-spec :family "Symbola" :size 13)
;;       doom-big-font (font-spec :family "Fira Code" :size 19))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;;
;; https://github.com/hlissner/emacs-doom-themes/tree/screenshots
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-snazzy)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-material)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-Iosvkem)
(setq doom-theme 'doom-monokai-pro)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq rustic-lsp-server 'rust-analyzer)

;;(setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
;;(setq lsp-haskell-process-path-hie "ghcide")
;;(setq lsp-haskell-process-args-hie ())
;; (map!
;;  :map haskell-mode-map
;;  :localleader
;;  "f" #'ormolu-format-buffer)


(map! :leader
      (:prefix-map ("c" . "code")
       (:when (featurep! :tools lsp)
          :desc "LSP describe thing" "h" #'lsp-describe-thing-at-point
          )
       )
)

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(use-package! ansi-color
  :config
  (defun display-ansi-colors ()
        (interactive)
        (ansi-color-apply-on-region (point-min) (point-max)))
)

(after! evil-snipe
  (evil-snipe-mode -1))

(setq lsp-terraform-server '("terraform-ls" "serve"))

(use-package! lsp-metals)

(setq dhall-use-header-line nil)
