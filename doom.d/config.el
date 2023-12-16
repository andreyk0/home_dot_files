;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Generate with
;;   doom env -o ~/.doom.d/myenv
;; and edit
(doom-load-envvars-file "~/.doom.d/myenv")

;; Remove top frame
(add-to-list 'default-frame-alist '(undecorated . t))
;; Modeline height
(setq doom-modeline-height 1)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Andrey Kartashov"
      user-mail-address "andrey.kartashov@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Cascadia Code" :size 12 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Cascadia Code" :size 12 :weight 'normal)
      )
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;;
;; https://github.com/hlissner/emacs-doom-themes/tree/screenshots
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-Iosvkem)
;; (setq doom-theme 'doom-material)
;; (setq doom-theme 'doom-material-dark)
;; (setq doom-theme 'doom-monokai-classic)
;; (setq doom-theme 'doom-monokai-pro)
;; (setq doom-theme 'doom-monokai-ristretto)
;; (setq doom-theme 'doom-monokai-spectrum)
(setq doom-theme 'doom-old-hope)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-opera)
;; (setq doom-theme 'doom-peacock)
;; (setq doom-theme 'doom-snazzy)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'wombat)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; default tab width
(setq-default tab-width 4)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; https://github.com/emacs-lsp/lsp-metals/issues/84
(require 'treemacs-treelib)
(require 'treemacs-extensions)
(setq rustic-lsp-server 'rust-analyzer)
(add-hook 'rust-mode-hook #'yas-minor-mode)


(require 'lsp)
(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
                     :major-modes '(rustic-mode)
                     :remote? t
                     :server-id 'rust-analyzer-remote))

(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "ormolu"))

(add-hook 'haskell-mode-hook
          (lambda ()
            (map! :leader
                  (:prefix-map ("c" . "code")
                               (:when (modulep! :tools lsp) :desc "LSP format buffer" "f" #'lsp-format-buffer)
                               )
                  )))


(map! :leader
      (:prefix-map ("c" . "code")
       (:when (modulep! :tools lsp)
        :desc "LSP describe thing" "h" #'lsp-describe-thing-at-point
        )

       :desc "Run build tool" "b" #'compile

       :desc "Toggle region comment" "#" #'comment-or-uncomment-region
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
(add-hook 'terraform-mode-hook #'yas-minor-mode)
(add-hook 'terraform-mode-hook
          (lambda ()
            (map!
             :leader
             :prefix "c"
             :desc "terraform fmt" "f" #'terraform-format-buffer
             )
            )
          )

(if (eq (getenv "USER") "akartashov")
  (use-package! lsp-metals))

(setq dhall-use-header-line nil)

(add-hook 'scala-mode-hook
          (lambda ()

            (map!
             :leader
             :prefix "c"
             :desc "SBT rerun last command" "c" #'sbt-run-previous-command
             )

            (map!
             :leader
             :prefix "c"
             :desc "SBT recompile" "C" #'sbt-do-compile
             )

            (map!
             :leader
             :prefix "c"
             :desc "SBT test" "t" #'sbt-do-test
             )

            )
          )

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq-default tab-width 2)
            )
          )

(add-hook 'python-mode-common-hook
          (lambda ()
            (setq-default tab-width 4)
            )
          )

(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))


(define-derived-mode arduino-mode c++-mode "ino" "Major mode for editing Arduino code.")
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))

(lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection '("just" "lsp"))
                     :major-modes '(arduino-mode)
                     :server-id 'arduino))

(dir-locals-set-class-variables
 'readonly-source
 '((nil . ((buffer-read-only . t)))))

(dir-locals-set-directory-class
 (concat (getenv "HOME") "/.cargo") 'readonly-source)
