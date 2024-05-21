;; -*- lexical-binding: t; -*-

(use-package gruber-darker-theme :ensure t)
(load-theme 'gruber-darker t)

;; I like the 3D box style of modeline
(set-face-attribute 'mode-line nil :box '(:style released-button))

(setq make-backup-files nil)
(setq backup-inhibited nil)
(setq create-lockfiles nil)

(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent)
  (setq native-compile-prune-cache t))

(setq custom-file (make-temp-file "emacs-custom-"))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package magit
  :ensure t)

(when (file-exists-p "~/.emacs.d/mail.el")
  (load-file "~/.emacs.d/mail.el"))
