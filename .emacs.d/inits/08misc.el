;; expand-region
(require 'expand-region)
(push 'er/mark-outside-pairs er/try-expand-list)
(bind-key "C-M-SPC" 'er/expand-region)


;; begin-end
(beginend-global-mode)


;; goto-chg
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)


;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)


;; editorconfig
(editorconfig-mode 1)


;; ediff
(setq
 ediff-window-setup-function 'ediff-setup-windows-plain
 ediff-split-window-function 'split-window-horizontally
 ediff-diff-options "-twB")


;; volatile-highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)


;; quickrun
(bind-key "<f5>" 'quickrun)


;; pcre
(require 'pcre2el)
(add-hook 'prog-mode-hook 'rxt-mode)
(setq reb-re-syntax 'pcre)


;; docker-tramp
(require 'docker-tramp-compat)


;; dumb-jump
(dumb-jump-mode)
(setq dumb-jump-selector 'ivy)


;; dired
(with-eval-after-load 'dired
  (bind-key "e" 'wdired-change-to-wdired-mode dired-mode-map)
  (defun my/dropbox ()
    (interactive)
    (find-file "~/Dropbox/"))
  (defun my/downloads ()
    (interactive)
    (find-file "~/Downloads/"))
  (defun my/githubimage ()
    (interactive)
    (find-file "~/Pictures/image/")))


;; yesnippet
(require 'yasnippet)
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)


;; projectile
(projectile-mode)
(counsel-projectile-on)
;; How to clear cache (M-x projectile-invalidate-cache)
(setq projectile-enable-caching t)
;; require ggtags
(setq projectile-tags-file-name "GTAGS")
(setq projectile-tags-command "gtags")


;; ggtags
(add-hook 'php-mode-hook 'ggtag-setting)
(add-hook 'enh-ruby-mode-hook 'ggtag-setting)
(add-hook 'c-mode-common-hook 'ggtag-setting)
(add-hook 'js2-mode-hook 'ggtag-setting)
(add-hook 'js2-jsx-mode-hook 'ggtag-setting)
(defun ggtag-setting ()
  (ggtags-mode 1))


;; eldoc
(require 'eldoc-extension)
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;;flycheck-package
(eval-after-load 'flycheck
  '(flycheck-package-setup))
(with-eval-after-load 'flycheck
  (flycheck-title-mode))


;; flyspell-correct
(require 'flyspell-correct-ivy)
(define-key flyspell-mode-map (kbd "C-:") 'flyspell-correct-previous-word-generic)
(add-hook 'git-commit-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)


;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(add-hook 'emacs-lisp-mode-hook 'turn-off-smartparens-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-off-smartparens-mode)
(add-hook 'lisp-mode-hook 'turn-off-smartparens-mode)
(add-hook 'ielm-mode-hook 'turn-off-smartparens-mode)
(add-hook 'scheme-mode-hook 'turn-off-smartparens-mode)
(add-hook 'slime-repl-mode-hook 'turn-off-smartparens-mode)


;; ansible
(add-hook 'yaml-mode-hook
          (lambda ()
	    (ansible 1)
            (company-mode 1)
	    (auto-complete-mode -1)
	    (add-to-list 'company-backends 'company-ansible)))

(setq ansible::vault-password-file "~/Dropbox/ansible/vault_pass")
(add-hook 'ansible-hook 'ansible::auto-decrypt-encrypt)

;; ansible-doc
(add-hook 'yaml-mode-hook #'ansible-doc-mode)
