;;; -*- lexical-binding: t; -*-
;; ======================================
;;; org
;; ======================================
;; /.emacs.d/lisp/my-org-custom.el
(use-package org
  :ensure nil				;built-in
  ;; :bind (("s-o e" . org-emphasize)
  ;; 	 ("s-o v" . org-toggle-inline-images))
  :custom
  (org-directory (expand-file-name "~/Dropbox/Docs/org/"))
  (org-adapt-indentation t)
  (org-hide-leading-stars t)
  (org-src-preserve-indentation t)
  (org-structure-template-alist
   '(("s" . "src")
     ("S" . "src emacs-lisp")
     ("C" . "comment")
     ("v" . "verse")
     ("q ".  "quote")))
  (org-startup-with-inline-images nil)
  (org-log-into-drawer t)
  (org-log-done 'time)
  (org-image-actual-width '(100))
  (org-todo-keywords '((sequence "TODO" "HOLD" "DONE"))))

(use-package ox-md
  :ensure org  ; org 패키지가 설치되어 있는지 확인합니다
  :after org   ; org 모드가 로드된 후에 ox-md를 로드합니다
  :config
  (require 'ox-md)
  (add-to-list 'org-export-backends 'md))

(use-package ox-latex
  :ensure nil  ; ox-latex is part of org
  :after org
  :custom
  (org-latex-title-command "\\maketitle \\newpage")
  (org-latex-toc-command "\\tableofcontents \\newpage")
  (org-latex-compiler "xelatex")
  (org-latex-to-pdf-process
   '("xelatex -interaction nonstopmode -output-directory %o %f"
     "xelatex -interaction nonstopmode -output-directory %o %f"
     "xelatex -interaction nonstopmode -output-directory %o %f"))
  :hook (org-mode . (lambda () (require 'ox-latex))))


;; ======================================
;;; org-capture
;; ======================================
(use-package org-capture
  :ensure nil
  :bind ("C-c c" . org-capture)
  :config
  (setq org-capture-templates
	'(("d" "Daily" entry (file+datetree "~/Dropbox/Docs/Person/Daily.org") "* %?")
	  ("t" "Tasks" entry (file "~/Dropbox/Docs/Person/Tasks.org") "* TODO %?")
     ;; ("t" "Tasks" entry (file+olp "~/Dropbox/Docs/Person/Tasks.org" "Schedule") "* TODO %?")
     ;; ("a" "Assist" table-line (file+headline "aMoney.org" "aMoney")
     ;;  "| %^{구분} | %^{일자} | %^{이름} | %^{연락처} | %^{관계} | %^{종류} | %^{금액} | %^{메모} |")
	  ("f" "FarmNote" entry (file+datetree "~/Dropbox/Docs/Person/dFarmNote.org") "* %?")))
  )

;; ======================================
;;; org-agenda
;; ======================================
(use-package org
  :ensure nil
  :bind ("C-c a" . org-agenda)
  :config
  ;;  (setq org-agenda-files '("Tasks.org" "Daily.org"))
  (setq org-agenda-files '("~/Dropbox/Docs/Person/Tasks.org"  "~/Dropbox/Docs/Person/Daily.org"))
  (setq org-agenda-prefix-format
	'((agenda . " %t %s")  ;" %t %-12:c%?-12t% s"
          (timeline . "  % s")
          (todo . " %i %-12:c")
          (tags . " %i %-12:c")
          (search . " %i %-12:c")))
  (setq org-agenda-format-date "%Y-%m-%d (%a)")  ; 날자 포맷. 가독성
  (setq org-agenda-current-time-string "← now ───────")
  (setq org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done)) ;완료항목 hidden
  (setq org-agenda-include-diary t))	;holidays 포함

;; ======================================
;;; org-bullets
;; ======================================
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "◎" "●" "○" "●" "○" "●")))

;; ======================================
;;; korean calendar
;; ======================================
(use-package calendar
  :hook (calendar-mode . cal-fixLayout)
  :config  
  (setq calendar-week-start-day 0
	calendar-day-name-array ["Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"]
        calendar-month-name-array ["1월" "2월" "3월" "4월" "5월" "6월" "7월" "8월" "9월" "10월" "11월" "12월"])

;;; calendar layout 보정. D2coding size
(defun cal-fixLayout ()
  (face-remap-add-relative 'default '(:family "Noto Sans Mono CJK KR" :height 160)))           

;; ======================================
;;; holidays
;; ======================================
(use-package calendar
  :ensure nil 				;built-in
  :config
  (setq my-holidays			;공휴일+음력기념일
	'((holiday-fixed 1 1 "새해")
	  (holiday-chinese  1  1 "설날")
	  (holiday-fixed 1 10 "딸 생일")
	  (holiday-fixed 3 1 "삼일절")
	  (holiday-fixed 3 19 "결혼일")
	  (holiday-chinese  4  8 "석탄일")
	  (holiday-fixed 5 5 "어린이날")
	  (holiday-fixed 6 6 "현충일")
	  (holiday-fixed 6 10 "아들생일")
	  (holiday-fixed 7 17 "제헌절")
	  (holiday-chinese  7  21 "장인제")
	  (holiday-chinese  8  4 "조부제")
	  (holiday-fixed 8 15 "광복절")
	  (holiday-chinese  8 15 "추석")
	  (holiday-chinese  9  3 "母생신")
	  (holiday-chinese  9  5 "父제")
	  (holiday-fixed 10 3 "개천절")
	  (holiday-fixed 10 9 "한글날")
	  (holiday-chinese  11  9 "장모생신")
	  (holiday-fixed 12 25 "성탄절")))  
  (setq 24solar-holidays			;24절기
	'((holiday-fixed 2 4 "입춘(새봄)")
	  (holiday-fixed 2 19 "우수(눈녹음)")
	  (holiday-fixed 3 5 "경칩(겨울잠 깸)")
	  (holiday-fixed 3 20 "춘분(낮 길어짐)")
	  (holiday-fixed 4 5 "청명")
	  (holiday-fixed 4 20 "곡우(봄비)")
	  (holiday-fixed 5 5 "입하")
	  (holiday-fixed 5 21 "소만(볕 잘듬)")
	  (holiday-fixed 6 6 "망종(씨앗)")
	  (holiday-fixed 6 21 "하지")
	  (holiday-fixed 7 7 "소서(더위 시작)")
	  (holiday-fixed 7 22 "대서(가장 더움)")
	  (holiday-fixed 8 7 "입추")
	  (holiday-fixed 8 23 "처서(가을바람)")
	  (holiday-fixed 9 7 "백로(이슬)")
	  (holiday-fixed 9 22 "추분(밤 길이)")
	  (holiday-fixed 10 8 "한로(이슬)")
	  (holiday-fixed 10 23 "상강(서리)")
	  (holiday-fixed 11 7 "입동")
	  (holiday-fixed 11 22 "소설(눈 시작)")
	  (holiday-fixed 12 7 "대설(눈 많음)")
	  (holiday-fixed 12 22 "동지")
	  (holiday-fixed 1 5 "소한")
	  (holiday-fixed 1 20 "대한")))
;; 원치않는 휴일 초기화
  (setq holiday-general-holidays nil)
  (setq holiday-local-holidays nil)
  (setq holiday-other-holidays nil)
  (setq holiday-christian-holidays nil)
  (setq holiday-hebrew-holidays nil)
  (setq holiday-islamic-holidays nil)
  (setq holiday-bahai-holidays nil)
  (setq holiday-oriental-holidays nil)
  (setq calendar-mark-holidays-flag t))	;holiday display
  (setq calendar-holidays (append my-holidays 24solar-holidays)))

(custom-set-faces
 '(holiday ((t (:foreground "red" :weight bold)))))


;; ======================================
;;; for org edit/custom function
;; --------------------------------------
(with-eval-after-load 'org  ; in org-mode
  (define-key org-mode-map (kbd "C-0") (lambda () 
                                         (interactive)
					 (end-of-line)
                                         (newline-and-indent)
                                         (next-line)
                                         (org-cycle)))
  (define-key org-mode-map (kbd "C-8") (lambda () 
                                         (interactive)
					 (end-of-line)
                                         (newline-and-indent)))
  (define-key org-mode-map (kbd "C-9") (lambda () 
                                         (interactive)
					 (end-of-line)
                                         (org-insert-heading))))

;; ======================================
;;; denote
;; ======================================
;; Denote 설정
(use-package denote
  :ensure t
  :bind("C-c n n" . denote)
  :custom
  (denote-directory (expand-file-name "~/Dropbox/Docs/org/denote"))
  (denote-known-keywords '("work" "personal" "reading"))
  (denote-infer-keywords t)
  (denote-sort-keywords t)
  (denote-file-type nil) ; 기본값으로 org 파일 사용
  (denote-prompts '(title keywords))
  :config
  (with-eval-after-load 'org-capture
    (add-to-list 'org-capture-templates
                 '("n" "New  Denote" plain
                   (file denote-last-path)
                   #'denote-org-capture
                   :no-save t
                   :immediate-finish nil
                   :kill-buffer t
                   :jump-to-captured t))))

;; Consult-Denote 설정
(use-package consult-denote
  :ensure t
  :after (consult denote)
  :bind
  (("C-c n s" . consult-denote)
   ("C-c n g" . consult-denote-grep)
   ("C-c n f" . consult-denote-file-type)
   ("C-c n b" . consult-denote-backlinks)
   ("C-c n k" . consult-denote-keywords))
  :custom
  (consult-denote-default-file-type 'org))



;;; end here
(provide 'my-org-custom)
