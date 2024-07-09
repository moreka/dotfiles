;; -*- lexical-binding: t; -*-

(set-face-attribute 'default nil
                    :family "Liberation Mono"
                    :height 120
                    :weight 'normal ;; 'medium for light theme
                    :width 'normal) ;; 'semi-expanded)

;; I like the 3D box style of modeline
(defun three-d-style(theme &rest args)
  (custom-set-faces
   `(mode-line
     ((t (:inherit mode-line
		   :box (:style released-button)))) t)))

(advice-add 'load-theme :after #'three-d-style)

(use-package solarized-theme :ensure t)
(load-theme 'solarized-dark t)

;; (use-package gruber-darker-theme :ensure t)
;; (load-theme 'gruber-darker t)

;; (use-package moe-theme :ensure t)
;;(load-theme 'moe-light t)

;; (use-package modus-themes :ensure t)
;; (setq modus-themes-mixed-fonts t)
;; (load-theme 'modus-operandi-tritanopia t)
;; (setq modus-themes-to-toggle '(modus-vivendi-tritanopia modus-operandi-tritanopia))


(setq make-backup-files nil)
(setq backup-inhibited nil)
(setq create-lockfiles nil)
(setq vc-follow-symlinks t)

(setq native-comp-async-report-warnings-errors 'silent)
(setq native-compile-prune-cache t)

(setq custom-file (make-temp-file "emacs-custom-"))

(column-number-mode 1)

;; Enable these
(mapc
 (lambda (command)
   (put command 'disabled nil))
 '(list-timers narrow-to-region narrow-to-page upcase-region downcase-region))

;; And disable these
(mapc
 (lambda (command)
   (put command 'disabled t))
 '(eshell project-eshell overwrite-mode iconify-frame diary))


(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)


(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package magit
  :ensure t)

;; LaTeX setup
(setq ispell-dictionary "american")

(use-package latex
  :ensure auctex
  :defer t
  :mode ("\\.tex\\'" . latex-mode)
  :hook ((LaTeX-mode . flyspell-mode)
 	 (LaTeX-mode . LaTeX-math-mode)
	 (LaTeX-mode . TeX-source-correlate-mode)
	 (LaTeX-mode . reftex-mode)
	 (LaTeX-mode . (lambda ()
			 (setq fill-column 70)
			 (auto-fill-mode 1)))
	 (LaTeX-mode . (lambda ()
			 (push (list 'output-pdf "Zathura") TeX-view-program-selection)
			 (setq display-line-numbers-type 'relative)
			 (display-line-numbers-mode)))
	 ;; (LaTeX-mode . (lambda ()
	 ;; 		 (use-package company-auctex :ensure t)
	 ;; 		 (use-package company-reftex :ensure t)
	 ;; 		 (make-local-variable 'company-backends)
	 ;; 		 (setq company-backends
	 ;; 		       '((company-capf company-reftex-labels company-reftex-citations company-dabbrev)))))
	 (LaTeX-mode . (lambda () (LaTeX-add-environments
				   '("theorem" LaTeX-env-label)
				   '("lemma" LaTeX-env-label))))
	 ;;(LaTeX-mode . (lambda () (add-hook 'post-command-hook #'my-yas-try-expanding-auto-snippets)))
	 )

  :config
  (setq-default TeX-master nil
		TeX-PDF-mode t)
  (setq TeX-parse-self t
	TeX-auto-save t
	reftex-plug-into-AUCTeX t
	font-latex-fontify-script nil
	font-latex-fontify-sectioning 'color)
  (setq reftex-label-alist
	'(("theorem" ?h "thm:" "~\\cref{%s}" t ("theorem" "th.") -2)
	  ("lemma" ?h "lem:" "~\\cref{%s}" t ("lemma" "lem.") -3)
	  ("proposition" ?h "prop:" "~\\cref{%s}" t ("proposition" "prop.") -4)
	  ("assumption" ?h "ass:" "~\\cref{%s}" t ("assumption" "ass.") -5)
	  ("corollary" ?h "cor:" "~\\cref{%s}" t ("corollary" "cor.") -6)
	  AMSTeX))
  (setq reftex-ref-style-default-list '("Cleveref" "Default")))

(use-package vertico
  :ensure t
  :config
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package rust-mode :ensure t)

(load "~/.emacs.d/mail.el" :no-error :no-message)
