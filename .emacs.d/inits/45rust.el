(setq racer-rust-src-path "~/Dropbox/emacs/rustc-1.14.0/src/")
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
;; When rust-format-on-save is set to t in rust-mode, rustfmt runs automatically
(with-eval-after-load 'rust-mode
  (setq-default rust-format-on-save t))
;; Launch racer and flycheck when editing rust files
(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)
                            (flycheck-rust-setup)))
;; Use racer's eldoc support
(add-hook 'racer-mode-hook #'eldoc-mode)
;; Use racer's supplementary support
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode-on)
                             (set (make-variable-buffer-local 'company-idle-delay) 0.1)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 1)))
