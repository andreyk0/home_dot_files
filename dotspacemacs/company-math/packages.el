(defconst company-math-packages
  '((company-math :toggle (configuration-layer/package-used-p 'company))))

(defun company-math/init-company-math ()
  (use-package company-math
    :defer nil
    :init
    (spacemacs|add-company-backends
      :backends company-math-symbols-unicode
      :modes haskell-mode
)))
