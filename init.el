;; Bootstrap use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
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

;; Turn off tool bar etc
(tool-bar-mode -1)
(menu-bar-mode -1)

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
  :config (progn
            (setq ivy-use-virtual-buffers t
                  ivy-height 10
                  ivy-count-format "(%d/%d) ")
            (ivy-mode 1)))

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
  (("C-x g" . magit-status))  
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ivy use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
