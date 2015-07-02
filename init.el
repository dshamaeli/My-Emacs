;;;;;;;;;;;;;;;;;;;;http://www.aaronbedra.com/emacs.d/;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;User details
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq user-full-name "Daniel Shamaeli")
;(setq user-mail-address "d_sh80@yahoo.com")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "PATH" (concat "/usr/local/bin:/opt/local/bin:/usr/bin:/bin:/usr/bin/node:" (getenv "PATH")))
(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Package Management
;;;the marmalade, and melpa repositories are also added
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Define default packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar daniel/packages '(ac-js2
			  ac-slime
			  angular-snippets
			  auto-complete
                          autopair
                          coffee-mode
                          deft
                          erlang
                          feature-mode
                          flycheck
                          gist
                          go-mode
                          graphviz-dot-mode
                          haml-mode
                          haskell-mode
                          htmlize
			  js2-mode
			  js3-mode
			  json-mode	
                          magit
                          markdown-mode
                          marmalade
			  neotree
                          nodejs-repl
                          o-blog
                          org
                          paredit
                          php-mode
                          puppet-mode
                          restclient
                          rvm
                          scala-mode
                          smex
                          sml-mode
                          solarized-theme
                          web-mode
                          writegood-mode
                          yaml-mode
			  yasnippet
 			  zenburn-theme)
  "Default packages")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Install default packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun daniel/packages-installed-p ()
  (loop for pkg in daniel/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (daniel/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg daniel/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Turn off splash Screen
;;;skip straight to the scratch buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Project explorer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Backup files
;;;turn backup off
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq make-backup-files nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Tell Emacsto use system clipboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Yes and No
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defalias 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Show Line Numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-linum-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;autopair-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'autopair)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Workspace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-directory "~/workspace/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet and angular-snippets
;;; should be loaded before auto complete so that they can work together
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'angular-snippets)
(require 'yasnippet)
(yas-global-mode t)
;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding to shift+tab
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;auto-complete
;;; should be loaded after yasnippet so that they can work together
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Competele file path
;;;http://superuser.com/questions/67170/how-do-i-complete-file-paths-in-emacs
;;;HippieExpand
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)
(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Language Hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;JS-mode

;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;(setq js2-highlight-level 3)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
;'(js3-auto-indent-p t)         ; it's nice for commas to right themselves.
'(js3-enter-indents-newline t) ; don't need to push tab before typing
'(js3-indent-on-enter-key t)   ; fix indenting before moving on
(setq js3-consistent-level-indent-inner-bracket t)

;;;Webmode

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(add-hook 'web-mode-hook (lambda () (flyspell-mode t)))

;;;TAB

(setq-default indent-tabs-mode nil)
;; set default tab char's display width to 4 spaces
(setq-default tab-width 4)

;;;Tern


(add-to-list 'load-path "~/.emacs.d/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)

(add-hook 'js3-mode-hook (lambda () (tern-mode t)))
(add-hook 'js3-mode-hook (lambda () (auto-complete-mode t)))
(add-hook 'js3-mode-hook (lambda () (flyspell-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))
;;; add this key-map to /tern/emacs/tern.el
;;;(define-key tern-mode-keymap [(control tab)] 'completion-at-point)
(ac-flyspell-workaround)

;;;GO-MODE
(add-to-list 'load-path "/home/daniel/.emacs.d/elpa/go-mode-20150129.313/")
(require 'go-mode-autoloads)
(add-to-list 'auto-mode-alist '("\\.go?\\'" . go-mode))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;open file with diffrent program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun prelude-open-with ()
  "Simple function that allows us to open the underlying
file of a buffer in an external program."
  (interactive)
  (when buffer-file-name
    (shell-command (concat
                    (if (eq system-type 'darwin)
                        "open"
                      (read-shell-command "Open current file with: "))
                    " "
                    buffer-file-name))))
;;; set key for opening file
(global-set-key (kbd "C-c o") 'prelude-open-with)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
