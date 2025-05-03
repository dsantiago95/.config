;; Set a new file for emacs to write to automatically
;; This file (~/.emacs) is for user made customizations
(setq custom-file "~/.emacs.custom.el")
(load-file custom-file)

;; (setq fancy-splash-image "/Applications/Emacs.app/Contents/Resources/etc/images/icons/splash.png")

(ido-mode 1)
(setq ring-bell-function 'ignore) ;; turns off the bell sound when pressing C-g and others
(tool-bar-mode 0)    ;; gets rid of the toolbar
(scroll-bar-mode 0)  ;; gets rid of the scroll bar
(line-number-mode)   ;; adds line number (L#) to status bar
(column-number-mode) ;; adds column number (#,#) to status bar
(show-paren-mode)    ;; highlight paranthesis pair

;; set line numbers for all buffers and make them relative
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Installing MELPA repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package lsp-java
  :ensure t
  :mode "\\.java\\'")

;; In addition to the "Bootstrap 'use-package" unless, the below is for Swift
;; functionality, and was taken directly from Swift.org contributor Alastair
;; Houghton

;; Locate sourcekit-lsp. In my case, the first or clause should return 
;; something like "/usr/bin/sourcekit-lsp"
(defun find-sourcekit-lsp ()
    (or (executable-find "sourcekit-lsp")
	(and (eq system-type 'darwin)
		 (string-trim (shell-command-to-string "xcrun -f sourcekit-lsp")))
	     "/usr/local/swift/usr/bin/sourcekit-lsp"))

;; Packages for Swift development

;; .editorconfig file support
(use-package swift-mode
  :ensure t
  :mode "\\.swift\\'"
  :interpreter "swift")

(use-package swift-helpful
  :ensure t)

;; Rainbow delimiters makes nested delimiters easier to understand
(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode . rainbow-delimiters-mode)))

;; Company mode (completion)
(use-package company
  :ensure t
  :config
  (global-company-mode +1))

;; Used to interface with swift-lsp
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((swift-mode . lsp)))

;; lsp-mode's UI modules
(use-package lsp-ui
  :ensure t)

;; sourcekit-lsp support
(use-package lsp-sourcekit
  :ensure t
  :after lsp-mode
  :custom
  (lsp-sourcekit-executable (find-sourcekit-lsp) "Find sourcekit-lsp"))
