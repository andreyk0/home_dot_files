;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Generate with
;;   doom env -o ~/.config/doom/myenv
;; and edit
(doom-load-envvars-file "~/.config/doom/myenv")

(setq gc-cons-threshold (* 128 1024 1024))

(add-hook 'projectile-after-switch-project-hook (lambda ()
                                                   (message "Clearing Projectile cache for %s..." (projectile-project-root))
                                                   (projectile-invalidate-cache nil)
                                                   (message "Projectile cache cleared.")))


(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; Remove top frame
(add-to-list 'default-frame-alist '(undecorated . t))
;; Modeline height
;;(setq doom-modeline-height 1)

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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Inter" :size 13 :weight 'normal)
      ;; This is necessary to ensure symbols and icons don't look weird
      doom-symbol-font (font-spec :family "Noto Color Emoji" :size 12 :weight 'normal)
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
(setq doom-theme 'doom-molokai)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; default tab width
(setq-default tab-width 4)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/")

;; Disables comment indent/continuation on Enter
(setq +default-want-RET-continue-comments nil)

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
(require 'lsp)

;; Magit
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; New frame behavior
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main")
  )

;; https://mise.jdx.dev/ide-integration.html#emacs
(when (locate-file "mise" exec-path)
  (progn (require 'mise)
         (add-hook 'after-init-hook #'global-mise-mode))
  )
;; CLI tools installed by Mise
;; See: https://www.emacswiki.org/emacs/ExecPath
;;(setenv "PATH" (concat (getenv "PATH") (concat ":" (getenv "HOME") "/.local/share/mise/shims")))
;;(setq exec-path (append exec-path '(concat (getenv "HOME") "/.local/share/mise/shims")))

(after! lsp-rust
	(setq lsp-rust-analyzer-server-command '("rust-analyzer"))
	(setq rustic-lsp-server 'rust-analyzer)
	)

(add-hook 'rust-mode-hook #'yas-minor-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (setq compile-command "cargo test --color=never")
            (map!
             :leader
             :prefix "c"
             :desc "format buffer" "f" #'rustic-cargo-fmt
             )
            )
          )

(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
                     :major-modes '(rustic-mode)
                     :remote? t
                     :server-id 'rust-analyzer-remote))

(dir-locals-set-class-variables
 'readonly-source
 '((nil . ((buffer-read-only . t)))))

(dir-locals-set-directory-class
 (concat (getenv "HOME") "/.cargo") 'readonly-source)

(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "ormolu"))


(add-hook 'lsp-mode-hook
          (lambda ()
            (map!
             :leader
             :prefix "c"
             :desc "LSP format buffer" "f" #'lsp-format-buffer
             )
            )
          )

(map! :leader
      (:prefix-map ("c" . "code")
       (:when (modulep! :tools lsp)
        :desc "LSP describe thing" "h" #'lsp-describe-thing-at-point
        )

       :desc "Run build tool" "b" #'compile

       :desc "Toggle region comment" "#" #'comment-or-uncomment-region
       )
      )


(use-package! ansi-color
  :config
  (defun display-ansi-colors ()
        (interactive)
        (ansi-color-apply-on-region (point-min) (point-max)))
)

(after! evil-snipe
  (evil-snipe-mode -1))

(after! lsp-terraform
	(setq lsp-terraform-server '("terraform-ls" "serve"))
	)
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

(add-hook 'scala-mode-hook
          (lambda ()
            (setq compile-command "just test")
            (map!
             :leader
             :prefix "c"
             :desc "Clean compile" "C" #'lsp-metals-clean-compile
             )
            )
          )

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq tab-width 2)
            )
          )

(add-hook 'python-mode-common-hook
          (lambda ()
            (setq tab-width 4)
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


(defcustom sql-formatter-dialect "postgresql"
  "SQL formatter dialect. [bigquery|hive|mariadb|plsql|postgresql|redshift|spark|sqlite|sql|snowflake]"
  :type 'string
  :require 'sql-mode
  :group 'sql-formatter)

(defun run-sql-formatter ()
  "Run buffer through a SQL formatter"
  (interactive)
  (shell-command-on-region (point-min) (point-max) (format "sql-formatter -c '{\"keywordCase\": \"upper\"}' --language %s" sql-formatter-dialect) t t
                           )
  )

(add-hook 'sql-mode-hook
          (lambda ()
            (map!
             :leader
             :prefix "c"
             :desc "SQL format" "f" #'run-sql-formatter
             )
            )
          )

;; Use spaces in justfiles
(add-hook 'just-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
          ))

(setq markdown-command "pandoc -s --highlight-style=breezeDark -o -")

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)
(after! org (add-hook 'org-mode-hook #'turn-off-smartparens-mode))

;; GQL schemas
(add-to-list 'auto-mode-alist '("\\.graphqls\\'" . graphql-mode))

;; JSON with comments
(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . js-ts-mode))

;; Linux device tree
(add-to-list 'auto-mode-alist '("\\.overlay\\'" . dts-mode))
(add-to-list 'auto-mode-alist '("\\.dts\\'" . dts-mode))
(add-to-list 'auto-mode-alist '("\\.dtsi\\'" . dts-mode))
