(setf *mode-line-timeout* 1)
(setf *time-modeline-string* "%F %H %M")
(setf *group-format* "%t")
(setf *window-format* "%n: %30t")

(load-module "battery-portable")
(load-module "cpu")
(load-module "mpd")
(load-module "mem")

(setf cpu::*cpu-modeline-fmt*        "%c"
      cpu::*cpu-usage-modeline-fmt*  "^f2^f0^[~A~2D%^]"
      mem::*mem-modeline-fmt*        "%a%p"
      mpd:*mpd-modeline-fmt*         "%a - %t"
      mpd:*mpd-status-fmt*           "%a - %t"
      *hidden-window-color*          "^**"
      *mode-line-highlight-template* "«~A»")

(defvar *mode-line-formatter-list*
  '(("%g") ("%W") ("^>") ("docker-running" . t) ("mu-unread" . t) ("%m") ("%C") ("%M") ("%B") ("%d"))
  "List of formatters for the modeline.")

(defun generate-modeline (elements &optional not-invertedp rightp)
  "Generate a modeline for StumpWM.
ELEMENTS should be a list of `cons'es which `car' is the modeline
formatter or the shell command to run, and their `cdr' is either nil
when the `car' is a formatter and t when it is a shell command."
  (when elements
    (cons (format nil
                  " ^[~A^]^(:bg \"~A\") "
                  (format nil "^(:fg \"~A\")^(:bg \"~A\")^f1~A^f0"
                          (if (xor not-invertedp rightp) phundrak-nord1 phundrak-nord3)
                          (if (xor not-invertedp rightp) phundrak-nord3 phundrak-nord1)
                          (if rightp "" ""))
                  (if not-invertedp phundrak-nord3 phundrak-nord1))
          (let* ((current-element (car elements))
                 (formatter       (car current-element))
                 (commandp        (cdr current-element)))
            (cons (if commandp
                      `(:eval (run-shell-command ,formatter t))
                    (format nil "~A" formatter))
                  (generate-modeline (cdr elements)
                                     (not not-invertedp)
                                     (if (string= "^>" (caar elements)) t rightp)))))))
(defcommand reload-modeline () ()
  "Reload modeline."
  (sb-thread:make-thread
   (lambda ()
     (setf *screen-mode-line-format*
           (cdr (generate-modeline *mode-line-formatter-list*))))))

(reload-modeline)
