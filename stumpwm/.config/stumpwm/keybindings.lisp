;; basics
(set-prefix-key (kbd "s-t"))
(define-key *root-map* (kbd "s-r") "restart-soft")
(define-key *root-map* (kbd "M-r") "restart-hard")
;; (define-key *top-map* (kbd "s-<return>") "exec alacritty")

;; focus moves
(define-key *top-map* (kbd "s-h") "move-focus left")
(define-key *top-map* (kbd "s-l") "move-focus right")
(define-key *top-map* (kbd "s-j") "move-focus down")
(define-key *top-map* (kbd "s-k") "move-focus up")
(define-key *top-map* (kbd "s-H") "move-window left")
(define-key *top-map* (kbd "s-L") "move-window right")
(define-key *top-map* (kbd "s-J") "move-window down")
(define-key *top-map* (kbd "s-K") "move-window up")

;; splits
(define-key *root-map* (kbd "v") "hsplit")
(define-key *root-map* (kbd "h") "vsplit")

;; quick launches
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;; Web jump (works for DuckDuckGo and Imdb)
(defmacro make-web-jump (name prefix)
  `(defcommand ,(intern name) (search) ((:rest ,(concatenate 'string name " search: ")))
    (nsubstitute #\+ #\Space search)
    (run-shell-command (concatenate 'string ,prefix search))))

(make-web-jump "duckduckgo" "firefox https://duckduckgo.com/?q=")

(define-key *root-map* (kbd "s-s") "duckduckgo")
