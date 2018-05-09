;; Bootstrap use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

(unless (package-installed-p 'diminish)
  (package-refresh-contents)
  (package-install 'diminish)
  )

(unless (package-installed-p 'bind-keys)
  (package-refresh-contents)
  (package-install 'bind-key)
  )

(eval-when-compile
  (require 'use-package)
  )
(require 'diminish)
(require 'bind-key)

;; Install quelpa for files not present in ELPA and MELPA.  Note that
;; there's an alternative way to bootstrap
;; use-package/quelpa/quelpa-use-package which involves using quelpa
;; to install use-package. See:
;; https://github.com/benaiah/quelpa-use-package-bootstrap-config
(use-package quelpa
  :ensure t
  )

(use-package quelpa-use-package
  :ensure t
  )

;; zoom-frm and dependencies. These require quelpa and
;; quelpa-use-package to be available
(use-package frame-fns
  :ensure t
  :quelpa (frame-fns :fetcher github :repo "emacsmirror/frame-fns")
  )
(use-package frame-cmds
  :ensure t
  :quelpa (frame-cmds :fetcher github :repo "emacsmirror/frame-cmds")
  )
(use-package zoom-frm
  :ensure t
  :quelpa (zoom-frm :fetcher github :repo "emacsmirror/zoom-frm")
  )


;; Themes
(use-package darktooth-theme
  :ensure t
  )

(use-package moe-theme
  :ensure t
  )

(use-package zenburn-theme
  :ensure t
  )

(use-package doom-themes
  :ensure t
  )

(load-theme 'darktooth t)

;; Turn off tool bar etc
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Highlight current line
(global-hl-line-mode 1)


;; Ivy ecosystem
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
         ("C-r" . swiper))
  :config (setq search-default-mode nil))
(use-package counsel
  :ensure t
  :bind
  (
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf) ; search recently edited files
   ("C-c f" . counsel-git)       ; search for files in git repo
   ("C-c s" . counsel-git-grep)  ; search for regexp in git repo
   ("C-c /" . counsel-ag)        ; search for regexp in git repo using ag
   ("C-c l" . counsel-locate)    ; search for files or else using locate
   )
  )

(use-package ivy
  :ensure t
  :diminish
  :config (progn
            (setq ivy-use-virtual-buffers t
                  ivy-height 10
                  ivy-count-format "(%d/%d) ")
            (ivy-mode 1)))

;; smex - integrates with ivy/swiper
;; (use-package smex
;;   :ensure t
;;   )

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode)
  )

;; which-key
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :diminish which-key-mode
  )

;; Magit
(use-package magit
  :ensure t
  :defer t
  :bind
  (("C-x g" . magit-status)
   ("C-x C-g" . magit-dispatch-popup)
   )
  )

;; Company
(use-package company               
  :ensure t
  :defer t
  :init
  (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)
    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode
  )

(use-package company-quickhelp          ; Documentation popups for Company
  :ensure t
  :defer t
  :init
  (add-hook 'global-company-mode-hook #'company-quickhelp-mode)
  )

;; flycheck
(use-package flycheck
  :ensure t
  :defer t
  :init
  (global-flycheck-mode)
  )

;; (use-package flycheck
;;   :ensure t
;;   :preface
;;   (declare-function flycheck-next-error flycheck nil)
;;   (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
;;   (fringe-mode (quote (4 . 0)))
;;   :init (global-flycheck-mode)
;;   :config
;;   ;(setq flycheck-emacs-lisp-load-path 'inherit)
;;   (setq flycheck-python-flake8-executable "flake8")
;;   (setq flycheck-highlighting-mode 'lines))


;; YAML mode
(use-package yaml-mode
  :ensure t
  :defer t
  )

;; Python
;; See: https://github.com/howardabrams/dot-files/blob/master/emacs-python.org
(use-package python
  :mode ("\\.py\\'" . python-mode)
        ("\\.wsgi$" . python-mode)
  :interpreter ("python" . python-mode)
  :init
  (setq-default indent-tabs-mode nil)
  :config
  (setq python-indent-offset 4)
  (add-hook 'python-mode-hook 'smartparens-mode)
  (add-hook 'python-mode-hook 'color-identifiers-mode))

(use-package jedi
  :ensure t
  :init
  (add-to-list 'company-backends 'company-jedi)
  :config
  (use-package company-jedi
    :ensure t
    :init
    (add-hook 'python-mode-hook (lambda () (add-to-list 'company-backends 'company-jedi)))
    (setq company-jedi-python-bin "python")))

(use-package anaconda-mode
  :ensure t
  :init (add-hook 'python-mode-hook 'anaconda-mode)
        (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  :config (use-package company-anaconda
            :ensure t
            :init (add-hook 'python-mode-hook 'anaconda-mode)
            (eval-after-load "company"
              '(add-to-list 'company-backends '(company-anaconda :with company-capf)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a4d03266add9a1c8f12b5309612cbbf96e1291773c7bc4fb685bfdaf83b721c6" default)))
 '(package-selected-packages (quote (ivy use-package)))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
