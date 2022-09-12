
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)


(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; パッケージ情報の更新
;;(package-refresh-contents)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(exec-path-from-shell-copy-envs '("PATH" "GOPATH" "GOBIN"))

;; バックアップファイルを作らない設定
(setq make-backup-files nil)
(setq auto-save-default nil)

;;
(add-to-list 'default-frame-alist '(font . "FiraCode-14" ))
(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x" "/=" "!=" "->" "*" "==" "+" "&&" "<=" ">=" ">>" "<<" "::" ";;" ":" ":="))
  :config (global-fira-code-mode))

;; キーバインド設定

(global-set-key (kbd "C-m") 'newline-and-indent)
;; C-h をバックスペースにする
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;; 別のキーバインドにヘルプキーを割り当てる
(global-set-key (kbd "C-x ?") 'help-command)
;; ウィンドウ切り替え
(global-set-key (kbd "C-t") 'other-window)

;; 日本語を優先する
(set-language-environment "Japanese")
;; 文字コードは UTF-8 を優先する
(prefer-coding-system 'utf-8)
;; DDSKKの設定
(global-set-key
 (kbd "C-x C-j") 'skk-mode)

;; カラム番号を表示
(column-number-mode t)
;; ファイルサイズの表示
(size-indication-mode t)
;; 時計を表示
(display-time-mode t)
;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")
;; 行番号を常に表示
(global-linum-mode t)
;; 


;; ;; 対応する括弧を強調表示
(setq show-paren-delay 0)
(show-paren-mode t)
(set-face-attribute 'show-paren-match nil
		    :background "white")

;; ;; paren のスタイル: expression は括弧内も強調表示
;;(setq show-paren-style 'expression)
;; 括弧の自動挿入
(electric-pair-mode t)


;; カラーテーマの設定
;; https://github.com/conao3/iceberg-theme.el
(leaf iceberg-theme
  :ensure t
  :config
  (iceberg-theme-create-theme-file)
  (load-theme 'solarized-iceberg-dark t))


;; terminal の設定
(when (require 'multi-term nil t)
(setq multi-term-program "/usr/bin/bash"))

 (add-to-list 'term-unbind-key-list "C-t" "ESC") 

;; company 設定
(use-package company
  :ensure nil
  :bind
  (("C-M-i" . company-complete)
   :map company-active-map
   ("M-n" . nil)
   ("M-p" . nil)
   ("C-h" . nil)
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("C-s" . company-filter-candidates)
   ("C-i" . company-complete-selection)
   ([tab] . company-complete-selection))
  :init
  (global-company-mode)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-backends '(company-capf))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (setq completion-ignore-case t))

(require 'yasnippet)

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (add-hook 'c++-mode-hook
            (lambda () (setq flycheck-clang-language-standard "c++17"))))

;; go-mode
(use-package go-mode
  :ensure t
  :commands go-mode
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

;; eglot
(use-package eglot
  :ensure t
  :config
  ;; C/C++
  (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd-14")))
  (add-hook 'c++-mode-hook 'eglot-ensure)
  ;; Go
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
  (add-hook 'go-mode-hook #'eglot-ensure)
  ;; format on save
  (add-hook 'c-mode-hook '(lambda() (add-hook 'before-save-hook 'eglot-format-buffer nil t)))
  (add-hook 'c++-mode-hook '(lambda() (add-hook 'before-save-hook 'eglot-format-buffer nil t)))
  (add-hook 'go-mode-hook '(lambda() (add-hook 'before-save-hook 'eglot-format-buffer nil t))))
(put 'set-goal-column 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck-package flycheck fira-code-mode multi-term ddskk magit yasnippet use-package go-mode go exec-path-from-shell eglot company color-theme-modern)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
