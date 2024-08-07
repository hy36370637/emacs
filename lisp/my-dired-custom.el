;;; -*- lexical-binding: t; -*-
;; ======================================
;;; dired
;; --------------------------------------
;; dired 관련 lisp 모음
;; /emacs/lisp/my-dired-custom.el
;; directory 우선/한글파일명 정렬불가(macOS) → 해결(setenv "LC_COLLATE" "C")
;; (use-package dired
;;   :preface
;;   (defun sof/dired-sort ()
;;     "Dired sort, directories first."
;;     (save-excursion
;;       (let ((buffer-read-only nil))
;;         (forward-line 2)
;;         (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
;;     (when (and (featurep 'emacs) (fboundp 'dired-insert-set-properties))
;;       (dired-insert-set-properties (point-min) (point-max)))
;;     (set-buffer-modified-p nil))
  
;;   (defun my/dired-jump-to-top()
;;     "Dired, jump to top"
;;     (interactive)
;;     (goto-char (point-min))
;;     (dired-next-line 2))

;;   (defun my/dired-jump-to-bottom()
;;     "Dired, jump to bottom"
;;     (interactive)
;;     (goto-char (point-max))
;;     (dired-next-line -1))
;;   :config
;; ;;  (setq dired-listing-switches "-alh")
;;   (setq dired-auto-revert-buffer t)
;;   (setq delete-by-moving-to-trash t)     ;삭제 →휴지통
;;   :bind
;;   (:map dired-mode-map
;;         ("M-<up>" . my/dired-jump-to-top)
;;         ("M-<down>" . my/dired-jump-to-bottom)
;; 	("C-<return>" . #'dired-do-open))   ; Emacs 30
;;   :hook (dired-after-readin . sof/dired-sort)) ;dired-mode에서 파일 로드 후 sof함수 호출

(use-package dired
  :ensure nil  ;; dired는 기본으로 포함된 패키지이므로 :ensure nil 사용
  :preface
  (defun sof/dired-sort ()
    "Dired 정렬, 디렉토리를 우선으로."
    (save-excursion
      (let ((buffer-read-only nil))
        (forward-line 2)
        (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
    (when (and (featurep 'emacs) (fboundp 'dired-insert-set-properties))
      (dired-insert-set-properties (point-min) (point-max)))
    (set-buffer-modified-p nil))

  (defun my/dired-jump-to-top()
    "Dired에서 맨 위로 이동."
    (interactive)
    (goto-char (point-min))
    (dired-next-line 2))

  (defun my/dired-jump-to-bottom()
    "Dired에서 맨 아래로 이동."
    (interactive)
    (goto-char (point-max))
    (dired-next-line -1))

  :config
  (setq insert-directory-program "gls" ;brew install coreutils
	dired-listing-switches "-alh"
	dired-auto-revert-buffer t
        delete-by-moving-to-trash t)  ;; 삭제 시 휴지통으로 이동
  :bind
  (:map dired-mode-map
        ("M-<up>" . my/dired-jump-to-top)
        ("M-<down>" . my/dired-jump-to-bottom)
        ("C-<return>" . dired-do-open))  ;; Emacs 30
  :hook (dired-after-readin . sof/dired-sort))  ;; dired-mode에서 파일 로드 후 sof/dired-sort 함수 호출

;; ======================================
;;; dired-narrow
;; --------------------------------------
;; Dired 모드에서 파일 목록 필터링
(use-package dired-narrowA
  :ensure t
  :after dired
  :bind
  (:map dired-mode-map
        ("/" . dired-narrow)))

;; ======================================
;; dired-subtree
;; --------------------------------------
;; Tab. sub directory 표시
;; (use-package dired-subtree
;;   :ensure t
;;   :after dired)

(provide 'my-dired-custom)
