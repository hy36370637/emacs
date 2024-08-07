;; ======================================
;;; Speed up emacs
;; ======================================
;; 가비지 수집 호출 횟수 줄이기
(setq gc-cons-threshold 100000000)
(add-hook 'emacs-startup-hook 'my/set-gc-threshold)
(defun my/set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))

;; ======================================
;;; custom file
;; ======================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (setq custom-file (concat user-emacs-directory "custom.el"))
;; (when (file-exists-p custom-file) (load custom-file 't))

;; ======================================
;;; package source list
;;; ======================================
;; (require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))
;;	("org" . "https://orgmode.org/elpa/")
;;	("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; ======================================
;;; use-package
;; ======================================
(require 'use-package)
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; ;; (setq use-package-always-ensure nil)

;; ======================================
;;; system-info
;; ======================================
(defvar my-laptop-p (eq system-type 'gnu/linux))
(defvar my-mactop-p (eq system-type 'darwin))
(defvar my-Macbook-p (string-equal system-name "MacBookAir.local"))

;; ======================================
;;; exec-path-from-shell
;; ======================================
;; MacOS PATH 설정
(use-package exec-path-from-shell
  :ensure t
  :if my-mactop-p
  :init
  (exec-path-from-shell-initialize))

;; ======================================
;;; load-my-custom-package
;; ======================================
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'my-org-custom)                       ; org-mode
(require 'my-dired-custom)                    ; dired
(require 'my-reading-mode-custom)   ; reading mode
(require 'my-play-streaming)                 ; radio 청취
(require 'my-emacs-super-keys)            ; minor. super key
(require 'my-completion)                        ; completion
(require 'my-web-search)

;; ======================================
;;; MacOS keyboard
;; ======================================
;; (setq mac-option-modifier 'meta)
;; (setq mac-command-modifier 'meta)
;; (setq ns-right-command-modifier 'super)
;; (setq mac-right-option-modifier 'control)

;; ======================================
;;; defalias
;; ======================================
;; (defalias 'linum-rel 'menu-bar--display-line-numbers-mode-relative)
;; (defalias 'linum-abs 'menu-bar--display-line-numbers-mode-absolute)
;; (defalias 'linum-none 'menu-bar--display-line-numbers-mode-none)

;; ======================================
;;; 외양
;; ======================================
(tool-bar-mode -1)                            ; 도구상자 비활성
;; (menu-bar-mode -1)
(toggle-scroll-bar -1)
(setq inhibit-startup-message t)     ;시작 메시지  안나오게
(setq visible-bell t )                             ; 경로 벨 대신 시각적인 벨로 표시
(setq initial-scratch-message nil)
(setq use-dialog-box nil)
(setq-default line-spacing 0.2)        ; 줄 간격 1.5
;; (setq-default cursor-type 'bar)	       ;cursor type hbar,bar,box
;; (setq frame-title-format "| dole's Emacs | %b |")

;; ======================================
;;; 작은 설정 들
;; ======================================
(setq default-directory  "~/Dropbox/Docs/org/")
(setq temporary-file-directory "~/Dropbox/Docs/tmpdir/")
(setq make-backup-files nil)
(setq kill-whole-line 1)
(setq search-highlight t)
;;      display-time-format "%b-%d(%a) %H:%M")
;;; Scroll setting
(setq scroll-margin 7)
(setq scroll-preserve-screen-position t)
(setq scroll-conservatively 101)

;; ======================================
;;; 자잘한 필수 모드
;; ======================================
(save-place-mode 1)
(global-font-lock-mode 1)
(global-visual-line-mode t) ;word wrap
(global-auto-revert-mode 1)
(transient-mark-mode t)
(column-number-mode t)
(display-time-mode 1)

;; ======================================
;;; modus theme
;; ======================================
(use-package emacs
  :config
  (require-theme 'modus-themes)
  (setq modus-themes-to-toggle '(modus-operandi modus-vivendi))
        ;; modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))
        ;; modus-themes-to-toggle '(modus-operandi-deuteranopia modus-vivendi-deuteranopia)
        ;; modus-themes-to-toggle '(modus-operandi-tritanopia modus-vivendi-tritanopia)
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
	modus-themes-mixed-fonts nil	;default nil
	modus-themes-variable-pitch-ui nil
	modus-themes-custom-auto-reload t
	modus-themes-disable-other-themes t))
;; Remove the border
(setq modus-themes-common-palette-overrides
      '((border-mode-line-active unspecified)
        (border-mode-line-inactive unspecified)))

;; ======================================
;;; start emacs (load theme by time)
;; ======================================
;; display-time-mode 사용.
;; (defun set-theme-by-time ()
;;   "set theme by time, loading emacs"
;;   (let ((current-hour (string-to-number (substring (current-time-string) 11 13))))
;;     (if (and (>= current-hour 9) (< current-hour 17))  ; 9시부터 17시까지
;;         (load-theme 'modus-operandi)
;;       (load-theme 'modus-vivendi))))
;; (set-theme-by-time)
(load-theme 'modus-operandi)

;; ======================================
;;; 단축키 prefix key
;; ======================================
(global-unset-key [f11])  ; able expose / MacOS
(global-unset-key (kbd "C-x o"))  ;remove  'other-window
;; (global-set-key (kbd "C-x C-m") 'execute-extended-command) ; M-x
(global-set-key (kbd "C-x C-r") 'restart-emacs)  ;emacs 29
(global-set-key (kbd "M-o") 'other-window)

;; ======================================
;;; 로케일, 한글
;; ======================================
(set-language-environment "Korean")
(set-locale-environment "ko_KR.UTF-8")	  ;kbd 한글 S-SPC
(setenv "LANG" "ko_KR.UTF-8")
(setenv "LC_COLLATE" "C")	                	  ;Dired 한글 파일명 정렬 macOS
(setq input-method-verbose-flag nil)
(setq input-method-highlight-flag nil)          ;입력 글자 밑줄방지

;; ======================================
;;; 글꼴 fonts
;; ======================================
;; (if (display-graphic-p)
;;     (progn
;;       ;;(set-frame-font "Noto Sans Mono CJK KR")
      (set-face-attribute 'default nil
                          :family "Noto Sans CJK KR"    ;Hack, Menlo;Noto Sans CJK KR
                          :height 160)
      (set-face-attribute 'fixed-pitch nil :family "Noto Sans Mono CJK KR")
      (set-face-attribute 'variable-pitch nil :family "Noto Sans CJK KR")
      (set-fontset-font nil 'hangul (font-spec :family "Noto Sans CJK KR")) ;)
;;  (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding")))

;; ======================================
;;; helpful
;; ======================================
(use-package helpful
  :ensure t
  :bind(("C-h k" . helpful-key)
	("C-c C-d" . helpful-at-point)
	("C-h C" . helpful-command)
	("C-h o" . helpful-symbol)))

;; ======================================
;;; recentF
;; ======================================
(use-package recentf
  :ensure t
  :init
  (recentf-mode 1)
  :custom
  (recentf-max-saved-items 30))

;; ======================================
;;; which-key
;; ======================================
(use-package which-key
  :ensure nil   ; built in Emacs 30
  :init
  (which-key-mode)
  :config
  ;; (which-key-setup-side-window-right)
  (setq which-key-idle-delay 0.2))

;; ======================================
;;; vertico
;; ======================================
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  (setq vertico-resize t)
  (setq vertico-cycle t))

;; ======================================
;;; marginalia
;; ======================================
(use-package marginalia
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; ======================================
;;; savehist
;; ======================================
(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; ======================================
;;; orderless
;; ======================================
;; advenced completion stlye
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; ======================================
;;; consult
;; ======================================
;; enhanced minibuffer commands, search
(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("C-x r x" . consult-register)
   ("C-x r b" . consult-bookmark)
   ("C-c k" . consult-kmacro)
   ;;   ("C-x C-r" . consult-recent-file)
   ("M-g o" . consult-outline)
   ("M-g h" . consult-org-heading)
   ("M-g a" . consult-org-agenda)
   ("M-g m" . consult-mark)
   ("M-s f" . consult-find)
   ("M-s g" . consult-grep)
   ("M-s t" . consult-theme))
  :hook (completion-list-mode . consult-preview-at-point-mode))

;; ======================================
;;; consult-dir
;; ======================================
;; insert paths into minibuffer prompts in Emacs
(use-package consult-dir
  :ensure t
  :bind (("C-c r d" . consult-dir)
  :map vertico-map
  ("C-c r d" . consult-dir)))

;; ======================================
;;; embark
;; ======================================
;; extended minibuffer actions and context menu
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act))
  :config
  (setq prefix-help-command #'embark-prefix-help-command))

;; ======================================
;;; embark-consult
;; ======================================
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; =======================================
;;; all-the-icons
;; ======================================-
(use-package nerd-icons
  :ensure t
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :after dired
  :if (display-graphic-p)
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; (use-package nerd-icons-completion
;;   :after completion
;;   :if (display-graphic-p)
;;   :config
;;   (add-hook 'completion-list-mode-hook 'nerd-icons-completion-mode))

;; ======================================
;;; eshell
;; ======================================
(use-package eshell
  :commands eshell
  :config
  (setq eshell-destroy-buffer-when-process-dies t))

;; ======================================
;;; modeline
;; ======================================
(use-package emacs
  :init
  ;; (setq mode-line-compact nil) ; Emacs 28
  (setq mode-line-right-align-edge 'right-margin) ; Emacs 30
  (setq-default mode-line-format
	      '("%e "
		mode-line-front-space
		(:eval (if (string= current-input-method "korean-hangul")
			   "KO"
			 "EN"))
		" Ⓗ "
		mode-line-buffer-identification       
		mode-line-frame-identification
		" Ⓨ "
		mode-line-modes
		mode-line-format-right-align  ;; emacs 30
		mode-line-position
		" Ⓚ "
		mode-line-misc-info)))

;; ======================================
;;; keycast
;; ======================================
(use-package keycast
  :ensure t
  :config
  (setq keycast-mode-line-insert-after 'mode-line-modes)
  (setq keycast-mode-line-window-predicate 'mode-line-window-selected-p)
  (setq keycast-mode-line-remove-tail-elements nil)
  (keycast-mode-line-mode -1))

;; ======================================
;;; pdf-view, tools
;; ======================================
;; only linux
;; (use-package pdf-tools
;;   :ensure nil
;;   :if my-laptop-p 
;;   :mode ("\\.pdf\\'" . pdf-view-mode) ; Automatically open PDFs in pdf-view-mode
;;   :config
;;   (setq pdf-view-display-size 'fit-width) ; Set the default zoom level
;;   (pdf-tools-install))

;; ======================================
;;; battery display
;; ======================================
(use-package battery
  :ensure nil 				;built in
  :if  my-Macbook-p
  :config 
  (setq battery-status-function 'battery-pmset) ;battery 정보
  (setq battery-mode-line-format "Ⓑ %p%%  ") 
  (display-battery-mode 1))

;; ======================================
;;; etc my-custom-fuction
;; ======================================
;; (defun my/insert-today (fm)
;;   "Inserts today() at point in the specified format."
;;   (interactive
;;    (list (completing-read "Select: " '("dash" "dot"))))
;;   (let ((format-string
;;          (cond
;;           ((string= fm "dash") "%Y-%m-%d")
;;           ((string= fm "dot") "%Y.%m.%d")
;;           (t (error "Invalid date format specified")))))
;;     (insert (format-time-string format-string))))

;;; --------------------------------------------------------
;;; 배경 투명 toggle
;;; --------------------------------------------------------
;; (defun set-transparency (&optional alpha-level)
;;   "Set the transparency of the Emacs frame."
;;   (interactive "P")
;;   (setq alpha-level (if alpha-level
;;                         (prefix-numeric-value alpha-level)
;;                       75)) ;; 기본값 설정
;;   (set-frame-parameter (selected-frame) 'alpha (cons alpha-level alpha-level)))

;; (defun toggle-transparency ()
;;   "Toggle transparency of the Emacs frame."
;;   (interactive)
;;   (let ((current-alpha (frame-parameter nil 'alpha)))
;;     (if (or (equal current-alpha '(0 . 0)) (equal current-alpha '(100 . 100)))
;;         (set-transparency 75)
;;       (set-transparency 100))))
