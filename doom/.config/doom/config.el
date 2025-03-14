;;; Loading Secrets
(load "/home/rp152k/.config/doom/secrets.el")
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(when (daemonp)
  (exec-path-from-shell-initialize))

;; Recursion depth
(setq max-lisp-eval-depth 10000)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name USER-FULL-NAME
      user-mail-address USER-EMAIL-ID)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
(setq doom-font (font-spec :family "FiraCodeNerdFontMono" :size 18 :weight 'medium))
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the 
;; (setq doom-theme 'doom-meltbus
;;       doom-meltbus-hl-line t)

;; (load-theme 'modus-operandi)
;;
;; Please set your themes directory to 'custom-theme-load-path
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "/home/rp152k/.config/emacs/.local/straight/repos/replace-colorthemes"))

(load-theme 'doom-outrun-electric t)

;; (setq pdf-view-midnight-colors (cons "#00ff00" "#000000")
;;       pdf-view-midnight-invert nil)


;; (doom/set-frame-opacity 0.9)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/home/rp152k/source/vcops/org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

                                        ;Misc

(defun life-hex-count ()
  "number of days I've been alive"
  (interactive)
  (let* ((birth (date-to-time "2000-05-01 19:30 IST"))
         (today (date-to-time (format-time-string "%Y-%m-%d %H:%M:%S %Z" (current-time)) ))
         (diff (float-time (time-subtract today birth))))
    (insert (concat " " (format "0x%X" (/ diff 86400))))))

(defun time-stamp ()
  "insert current time stamp"
  (interactive)
  (insert (format "%s" (format-time-string "%Y-%m-%d %H:%M:%S %Z" (current-time)))))

(defun hex-ops ()
  "hexify decimal number at point, invoke life hex at count if nil"
  (interactive)
  (defun delete-word-at-point ()
    (kill-word 1)
    (backward-kill-word 1))
  (defun valid-number-p (str)
    "Check if a string is a valid number."
    (string-match-p "^[+-]?[0-9]*\\.?[0-9]+\\(?:[eE][+-]?[0-9]+\\)?$" str))
  (let ((dec-days (word-at-point)))
    (cond ((null dec-days) (life-hex-count))
          ((valid-number-p dec-days) (progn
                                       (delete-word-at-point)
                                       (insert (format " 0x%X " (string-to-number dec-days))))))))

                                        ; GTD

(use-package! org
  :config
  (setq org-startup-numerated t)
  (setq org-agenda-files '("/home/rp152k/source/vcops/org/GTD/GTD_HQ.org"))
  (setq org-capture-templates
	'(("n" "Next Action" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "NA")
           "* TODO %?\n  %i\n  %a")
          ("m" "Meet" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Meets")
           "* @ %? w/")
	  ("e" "Event" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Events")
           "* %?\nSCHEDULED: %T\n  %i")
          ("i" "IN" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "INQ")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("k" "ICBM" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "ICBM")
           "* %?\nEntered on %U\n  %i\n  %a")
	  ("t" "Tickler" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Tickler")
	   "* WAIT %?\nDEFER THOUGHT TO: %T\n %i"))))


                                        ;roam (+roam2)
(use-package! org-roam
  :config
  (setq org-roam-directory "/home/rp152k/source/vcops/org/roam/Content"))


(defun gtd-workspace()
  "open the GTD workspace"
  (interactive)
  (find-file "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org"))

                                        ;blogging
(use-package! easy-hugo
  :config
  (setq easy-hugo-basedir "/home/rp152k/source/vcops/thebitmage.com"))

                                        ;gptel

(defvar GPTEL-PROVIDER "openai"
  "Provider for GPTel.")

(defvar GPTEL-MODELS
  (list
   (cons "openai" 'gpt-4o-mini)
   (cons "gemini" 'gemini-2.0-flash-exp))
  "List of models for GPTel.")

(defvar GPTEL-PROMPTS
  '(("base" . "be precise, exhaustive, unbiased, analytical and critical")
    ("epistemology" . "you are an intelligent epistemological engineer...")
    ("swe" . "you are an experienced software engineer..."))
  "List of prompts for GPTel.")

(use-package! gptel
  :config
  (setq
   gptel-api-key  (cdr (assoc GPTEL-PROVIDER API-KEYS))
   gptel-model   (cdr (assoc GPTEL-PROVIDER GPTEL-MODELS))
   gptel-default-mode 'org-mode
   gptel--system-message (cdr (assoc "base" GPTEL-PROMPTS)))
  (unless (equal GPTEL-PROVIDER "openai")
    (setq
     gptel-backend (funcall  (intern (format "gptel-make-%s" GPTEL-PROVIDER))
                             GPTEL-PROVIDER
                             :key gptel-api-key
                             ;; :models ,(intern (format "gptel--%s-models" GPTEL-PROVIDER))
                             :stream t))))
(defun gptel-prompt-alter ()
  "alter GPTEL prompt from a predefined list from gptel-conf.el "
  (interactive)
  (let ((prompt (completing-read "gptel prompt: " GPTEL-PROMPTS)))
    (setq gptel--system-message (cdr (assoc prompt GPTEL-PROMPTS)))))

(defun epistemological-overview ()
  "init an epistemological overview forcontext preceding the cursor"
  (interactive)
  (insert "\n* Epistemological Overview\n")
  (gptel-send))

(defun systems-breakdown-overview ()
  "init a systems breakdown for context preceding the cursor"
  (interactive)
  (insert "\n* Systems Breakdown\n")
  (gptel-send))

(defun strategic-tasks-breakdown ()
  "init a strategic tasks breakdown for context preceding the cursor"
  (interactive)
  (insert "\n* Strategic Tasks Breakdown\n")
  (gptel-send))


                                        ;citar
(use-package! citar
  :custom
  (org-cite-global-bibliography '("/home/rp152k/source/vcops/org/roam/Content/bib/references.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliographies org-cite-global-bibliography)
  (citar-bibliography org-cite-global-bibliography))

                                        ;org-roam-ui
(use-package! org-roam-ui
  :after org-roam ;; or :after org
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

                                        ;LSP
(use-package! lsp-mode
  :hook (lsp-mode . (lambda ()
                      (let ((lsp-keymap-prefix "C-M-l"))
                        (lsp-enable-which-key-integration))))
  :config
  (define-key lsp-mode-map (kbd "C-M-l") lsp-command-map)
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-diagnostics-provider :none)
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-signature-auto-activate t)
  (setq lsp-signature-render-documentation t)
  (setq lsp-completion-provider :capf)
  (setq lsp-completion-show-detail t)
  (setq lsp-enable-snippet t)
  (setq lsp-modeline-code-action t))

                                        ; Conda
(use-package! conda
  :config
  (setq conda-anaconda-home (expand-file-name  "~/miniforge3"))
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode -1)
  (add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
                                         (conda-env-activate-for-buffer)))))

;; Ultra Scroll
(use-package ultra-scroll
  :init
  (setq scroll-conservatively 101
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

                                        ; Compile and Shell
(setq shell-file-name "bash"
      shell-command-switch "-ic")

                                        ;Lisp
(load "~/quicklisp/clhs-use-local.el" 'noerror)
(map! :i "M-[" #'lispy-brackets [])

                                        ; Dap maps
(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)


                                        ; Custom Maps
;; leader maps
(map! :leader
      "z" #'+zen/toggle-fullscreen
      "c b" #'blink-cursor-mode
      "g d i" #'godoc
      "m o i" #'doom/set-frame-opacity
      "m p s" #'python-shell-send-statement
      "m r" #'python-shell-send-region
      "m p r" #'+python/open-ipython-repl
      "m p f" #'python-shell-send-file
      "m h t" #'modus-themes-toggle
      "m a h" #'pdf-annot-add-highlight-markup-annotation
      "m a m" #'pdf-annot-add-markup-annotation
      "m a u" #'pdf-annot-add-underline-markup-annotation
      "m a t" #'pdf-annot-add-text-annotation
      "m a x" #'pdf-annot-add-strikeout-markup-annotation
      "m a s" #'pdf-annot-add-squiggly-markup-annotation
      "m a l" #'pdf-annot-list-annotations
      "r s" #'restclient-http-send-current
      "w w" #'switch-window
      "l h"  #'life-hex-count
      "l t" #'time-stamp
      "o g" #'gtd-workspace
      "s w" #'eww
      "t t" #'tldr
      "e h" #'easy-hugo
      "e x" #'eros-eval-defun
      "e w" #'eww-switch-to-buffer
      "e u" #'eww-open-in-new-buffer
      "e c" #'eww-copy-page-url
      "n i l" #'org-insert-link
      "i g h" #'gptel
      "i g s" #'gptel-send
      "i g m" #'gptel-menu
      "c e" #'org-cite-insert
      "c o" #'citar-open
      "c d" #'citar-dwim
      "s /" #'+vertico/project-search-from-cwd
      "i g a p" #'gptel-prompt-alter
      "i g i s b" #'systems-breakdown-overview
      "i g i e" #'epistemological-overview
      "i g i t b" #'strategic-tasks-breakdown)
