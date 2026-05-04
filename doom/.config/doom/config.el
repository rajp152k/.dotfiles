;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; STATE MANAGEMENT

(load! "state.el")

(when (file-exists-p STATE-SECRETS-FILE)
  (load STATE-SECRETS-FILE 'noerror))

(when (daemonp)
  (exec-path-from-shell-initialize))

;; Recursion depth
(setq max-lisp-eval-depth 10000)

;; User Information
(setq user-full-name STATE-USER-FULL-NAME
      user-mail-address STATE-USER-EMAIL)

                                        ; Aesthetics

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;;(setq doom-font (font-spec :family "FiraCodeNerdFontMono" :size 18 :weight 'medium))
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Terminess Nerd Font Mono" :size 18 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Terminess Nerd Font" :size 18))

(setq doom-font-increment 0)

(setq doom-big-font (font-spec :family "Terminess Nerd Font Mono" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the 

;; Please set your themes directory to 'custom-theme-load-path
(add-to-list 'custom-theme-load-path
             (file-name-as-directory STATE-CUSTOM-THEMES-PATH))
(add-to-list 'custom-theme-load-path
             (file-name-as-directory STATE-BIT-MAGE-THEME))

(setq doom-theme 'bit-mage)
(load-theme 'bit-mage t)

(setq pdf-view-midnight-colors (cons "#00ff00" "#000000")
      pdf-view-midnight-invert nil)


;; completion case ignore
(setq completion-ignore-case t)

;; tab completion completion
(setq tab-always-indent 'complete)

(doom/set-frame-opacity 0.9271)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

                                        ;Doom Scratch
(setq doom-scratch-initial-major-mode 'org-mode)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory STATE-ORG-DIR)


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

                                        ;Rainbow Delimiters
(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

                                        ;Better Jumper - fix jump tracking for navigation
(after! better-jumper
  (better-jumper-mode +1))

(after! cider
  (advice-add #'cider-find-var :around #'doom-set-jump-a)
  (advice-add #'cider-find-dwim :around #'doom-set-jump-a))

(after! xref
  (advice-add #'xref-find-definitions :around #'doom-set-jump-a)
  (advice-add #'xref-find-references :around #'doom-set-jump-a))

(after! evil
  (advice-add #'evil-goto-definition :around #'doom-set-jump-a))


                                        ;Misc
(defmacro generate-bindable-lambda (&rest body)
  `#'(lambda ()
       (interactive)
       ,@body))

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

(defun insert-youtube-video-transcript ()
  "extract youtube transcript"
  (interactive)
  (let ((url (completing-read "video url:" (cl-remove-if-not
                                            (lambda (victim)
                                              (or (string-match-p "https://youtu.be" victim)
                                                  (string-match-p "https://www.youtube" victim)
                                                  (string-match-p "https://youtube" victim)))
                                            (cl-mapcar (lambda (x) (substring-no-properties x)) kill-ring)))))
    (with-current-buffer (get-buffer-create (format
                                             "*%s*"
                                             url))
      (insert (shell-command-to-string (format "fabric -y %s"
                                               url)))
      (display-buffer (current-buffer)))))

(setq shell-command-prompt-show-cwd t)


                                        ; Nov
(use-package! nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

                                        ; Babel
(use-package! org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t))))


                                        ; GTD

(use-package! org
   :config
   (setq org-startup-numerated t)
   (setq org-agenda-files (list STATE-ORG-GTD-HQ))
   (setq org-capture-templates
         '(("e" "Executions" entry (file+headline STATE-ORG-GTD-HQ "Executions")
            "* TODO [%]  [execute] %?\n  %i\n  %a")
           ("m" "Meditations" entry (file+headline STATE-ORG-GTD-HQ "Meditations")
            "* TODO [%]  [meditate] %?\n  %i\n  %a")
           ("c" "Collaborations" entry (file+headline STATE-ORG-GTD-HQ "Collaborations")
            "* @ %? w/")
           ("a" "Annotations" entry (file+headline STATE-ORG-GTD-HQ "Annotations")
            "* : %?")
           ("i" "Ingestions" entry (file+headline STATE-ORG-GTD-HQ "Ingestions")
            "* : %?"))))

(defun gtd-workspace-archive ()
  "Archive every heading whose TODO state is DONE in all `org-agenda-files`."
  (interactive)
  (let ((files  (org-agenda-files))
        (count  0))
    (dolist (file files)
      (with-current-buffer (find-file-noselect file)
        ;; Make sure we see the whole buffer even if you've narrowed
        (org-with-wide-buffer
         (let (done-markers)
           (goto-char (point-min))
           ;; collect every DONE heading
           (while (re-search-forward org-heading-regexp nil t)
             (when (string= (org-get-todo-state) "DONE")
               (push (point-marker) done-markers)))
           ;; process from bottom to top
           (dolist (mk (sort done-markers
                             (lambda (a b)
                               (> (marker-position a)
                                  (marker-position b)))))
             (goto-char (marker-position mk))
             (org-archive-subtree)
             (cl-incf count)
             (set-marker mk nil))))
        ;; save only if changed
        (when (buffer-modified-p)
          (save-buffer))))
    (message "Archived %d DONE entries across %d files"
             count (length files))))

                                        ;roam (+roam2)

(use-package! org-roam
  :config
  ;; (setq org-roam-database-connector 'emacsql-sqlite-builtin)
  (setq org-roam-directory STATE-ORG-ROAM-DIR))


                                        ; formatting
(defun sanitize-perplexity-citations ()
  "Remove [non-space] patterns from selection or buffer."
  (interactive)
  (evil-ex-nohighlight)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "\\[[^ ]\\]" nil t)
        (replace-match "")))))


                                        ; GTD

(defvar ORG-GTD-HQ-LOC  STATE-ORG-GTD-HQ)

(defun gtd-workspace()
  "open the GTD workspace"
  (interactive)
  (find-file ORG-GTD-HQ-LOC))

                                        ; k8s
(use-package! kubernetes
  :config
  (fset 'k8s 'kubernetes-overview)
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))

(use-package! kubernetes-evil
  :after kubernetes)


                                        ;pi-coding-agent
(use-package! pi-coding-agent
  :init (defalias 'pi 'pi-coding-agent))

                                        ;Whisper

(defun rk/get-ffmpeg-device ()
   "Gets the list of devices available to ffmpeg.
The output of the ffmpeg command is pretty messy, e.g.
   [AVFoundation indev @ 0x7f867f004580] AVFoundation video devices:
   [AVFoundation indev @ 0x7f867f004580] [0] FaceTime HD Camera (Built-in)
   [AVFoundation indev @ 0x7f867f004580] AVFoundation audio devices:
   [AVFoundation indev @ 0x7f867f004580] [0] Cam Link 4K
   [AVFoundation indev @ 0x7f867f004580] [1] MacBook Pro Microphone
   so we need to parse it to get the list of devices.
   The return value contains two lists, one for video devices and one for audio devices.
   Each list contains a list of cons cells, where the car is the device number and the cdr is the device name."
   (when (not (or STATE-IS-MACOS STATE-IS-LINUX))
     (message "Whisper device detection may require platform-specific adjustments"))

  (let ((lines (string-split (shell-command-to-string "ffmpeg -list_devices true -f avfoundation -i dummy || true") "\n")))
    (cl-loop with at-video-devices = nil
             with at-audio-devices = nil
             with video-devices = nil
             with audio-devices = nil
             for line in lines
             when (string-match "AVFoundation video devices:" line)
             do (setq at-video-devices t
                      at-audio-devices nil)
             when (string-match "AVFoundation audio devices:" line)
             do (setq at-audio-devices t
                      at-video-devices nil)
             when (and at-video-devices
                       (string-match "\\[\\([0-9]+\\)\\] \\(.+\\)" line))
             do (push (cons (string-to-number (match-string 1 line)) (match-string 2 line)) video-devices)
             when (and at-audio-devices
                       (string-match "\\[\\([0-9]+\\)\\] \\(.+\\)" line))
             do (push (cons (string-to-number (match-string 1 line)) (match-string 2 line)) audio-devices)
             finally return (list (nreverse video-devices) (nreverse audio-devices)))))

(defun rk/find-device-matching (string type)
  "Get the devices from `rk/get-ffmpeg-device' and look for a device
matching `STRING'. `TYPE' can be :video or :audio."
  (let* ((devices (rk/get-ffmpeg-device))
         (device-list (if (eq type :video)
                          (car devices)
                        (cadr devices))))
    (cl-loop for device in device-list
             when (string-match-p string (cdr device))
             return (car device))))

(defcustom rk/default-audio-device nil
  "The default audio device to use for whisper.el and outher audio processes."
  :type 'string)

(defun rk/select-default-audio-device (&optional device-name)
  "Interactively select an audio device to use for whisper.el and other audio processes.
If `DEVICE-NAME' is provided, it will be used instead of prompting the user."
  (interactive)
  (let* ((audio-devices (cadr (rk/get-ffmpeg-device)))
         (indexes (mapcar #'car audio-devices))
         (names (mapcar #'cdr audio-devices))
         (name (or device-name (completing-read "Select audio device: " names nil t))))
    (setq rk/default-audio-device (rk/find-device-matching name :audio))
    (when (boundp 'whisper--ffmpeg-input-device)
      (setq whisper--ffmpeg-input-device (format ":%s" rk/default-audio-device)))))

(use-package! whisper
  :load-path STATE-WHISPER-PATH
  :bind ("C-M-w" . whisper-run)
  :config
  (setq whisper-install-directory "/tmp/"
        whisper-model "base"
        whisper-language "en"
        whisper-translate nil
        whisper-cursor-return 'start
        whisper-use-threads (/ (num-processors) 2)))

                                        ; GPTel

(defvar GPTEL-PROVIDER "openrouter")

(defvar GPTEL-MODELS
  (list
   (cons "openrouter" 'minimax/minimax-m2.5)))

(defvar GPTEL-PROMPTS
  '(("Raw" .  "be precise, exhaustive, unbiased, analytical and critical")
    ("*:Jargonize" .  "respond only in concise, org-mode outlines. Use asterisks native to the org mode tree structure and never for any text formatting constructs. always start with a toplevel tree with single asterix. assume expertize with polymathic knowledge and exceptional contextual comprehension on the reader's end. no lengthy elaborations unless explicitly asked for.")))

(use-package! gptel
  :config
  (setq gptel--rewrite-message "")
  (setq gptel-api-key (cdr (assoc GPTEL-PROVIDER API-KEYS))
        gptel-model (cdr (assoc GPTEL-PROVIDER GPTEL-MODELS))
        gptel-default-mode 'org-mode
        gptel--system-message (cdr (assoc "Raw" GPTEL-PROMPTS)))

  (setq gptel-model   'google/gemini-2.5-flash
        gptel-backend
        (gptel-make-openai "OpenRouter"
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key (cdr (assoc "openrouter" API-KEYS))
          :models '(openai/o4-mini-high
                    openai/o4-mini
                    openai/gpt-5
                    openai/gpt-5-chat
                    openai/gpt-5-mini
                    openai/gpt-5-nano
                    openai/gpt-5-codex

                    minimax/minimax-m2.5

                    meta-llama/llama-4-maverick
                    meta-llama/llama-4-scout

                    deepseek/deepseek-v3.1-terminus

                    anthropic/claude-opus-4.5
                    anthropic/claude-sonnet-4.5
                    anthropic/claude-haiku-4.5

                    google/gemini-2.5-flash-lite
                    google/gemini-2.5-flash
                    google/gemini-2.5-pro
                    google/gemini-3-pro-preview
                    google/gemini-3-flash-preview
                    google/gemma-3n-e4b-it
                    google/gemini-3.1-pro-preview

                    perplexity/sonar
                    perplexity/sonar-pro
                    perplexity/sonar-deep-research
                    perplexity/sonar-reasoning-pro
                    perplexity/sonar-reasoning

                    x-ai/grok-code-fast-1
                    x-ai/grok-4-fast
                    x-ai/grok-4))))



(defun gptel-prompt-alter ()
  "alter GPTEL prompt from a predefined list from gptel-conf.el "
  (interactive)
  (let ((prompt (completing-read "gptel prompt: " GPTEL-PROMPTS)))
    (setq gptel--rewrite-directive (cdr (assoc prompt GPTEL-PROMPTS)))
    (setq gptel--system-message (cdr (assoc prompt GPTEL-PROMPTS)))))

(defun dispatch-gptel-prompt-header-pair (init-header prompt)
  (insert (format "\n* %s \n" init-header))
  (let ((gptel--system-message (cdr (assoc prompt GPTEL-PROMPTS))))
    (gptel-send)))

(defun dispatch-ephemeral-gptel-base-send ()
  "init an analysis using a custom prompt"
  (interactive)
  (let ((init-header (read-string "analysis header:"))
        (prompt (completing-read "gptel-prompt: " GPTEL-PROMPTS)))
    (dispatch-gptel-prompt-header-pair init-header prompt)))

(defmacro gptel-prompt-lambda (header prompt)
  `(generate-bindable-lambda
    (dispatch-gptel-prompt-header-pair
     ,header
     ,prompt)))

(use-package! gptel-mcp)

                                        ;citar
(use-package! citar
  :custom
  (org-cite-global-bibliography '(STATE-ORG-ZOTERO-BIB"))
  (citar-bibliography '(STATE-ORG-ZOTERO-BIB"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliographies org-cite-global-bibliography))

                                        ;org-roam-ui
(use-package! org-roam-ui
  :after org-roam ;; or :after org
  :config
  (setq org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t
        org-roam-ui-browser-function #'browse-url-firefox
        org-roam-ui-sync-theme nil
        org-roam-ui-custom-theme '((bg . "#000000")
                                   (bg-alt . "#000800")
                                   (fg . "#00FF00")
                                   (fg-alt . "#00FF00")
                                   (red . "#FF0066")
                                   (orange . "#FF9933")
                                   (yellow . "#FFFF33")
                                   (green . "#33FF33")
                                   (cyan . "#33FFFF")
                                   (blue . "#6666FF")
                                   (violet . "#9933FF")
                                   (magenta . "#FF33FF"))))                                        ;LSP

(defun org-roam-ui-global-graph ()
  (interactive)
  (websocket-send-text org-roam-ui-ws-socket
                       (json-encode `((type . "command")
                                      (data . ((commandName . "follow")
                                               (id . "this is definitely not going to be a valid roam id : awesome hack indeed : local of a nil node")))))))
(defun org-roam-ui-local-graph ()
  (interactive)
  (websocket-send-text org-roam-ui-ws-socket
                       (json-encode `((type . "command")
                                      (data . ((commandName . "follow")
                                               (id . ,(org-roam-id-at-point))))))))

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

                                        ; LSP-lang-specific
;; (after! lsp-mode
;;   (setq lsp-java-jdt-ls-command "/opt/homebrew/bin/jdtls" ))

                                        ; uv-mode
(use-package! uv-mode
  :config
  (add-hook 'python-mode-hook #'uv-mode-auto-activate-hook)
  (add-hook 'hy-mode-hook #'uv-mode-auto-activate-hook))
                                        ; Conda
;; (use-package! conda
;;   :config
;;   (setq conda-anaconda-Users (expand-file-name  "~/miniforge3"))
;;   (conda-env-initialize-interactive-shells)
;;   (conda-env-initialize-eshell)
;;   (conda-env-autoactivate-mode -1)
;;   (add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
;;                                          (conda-env-activate-for-buffer)))))

                                        ; wakatime
(use-package! wakatime-mode
  :config
  (global-wakatime-mode))

                                        ; ultra Scroll

(use-package! ultra-scroll
  :init
  (setq scroll-conservatively 101
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

                                        ; Compile and Shell
(setq shell-file-name "bash"
      shell-command-switch "-c")

                                        ; vterm
(after! vterm
  (add-hook 'vterm-mode-hook (lambda () (display-line-numbers-mode -1))))

                                        ; cider
(use-package! cider
  :config
  (setq cider-overlays-use-font-lock t))

                                        ;clojure-ts-mode grammar
;; Pin the tree-sitter-clojure grammar to the revision clojure-ts-mode expects.
;; Without this, Doom's set-tree-sitter! pulls the default master branch which
;; lacks the `str_content' node type, causing treesit-query-error on every buffer.
(after! clojure-ts-mode
  (setq clojure-ts-grammar-recipes
        '((clojure "https://github.com/sogaiu/tree-sitter-clojure.git"
                   "unstable-20250526")
          (markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                           "v0.5.2"
                           "tree-sitter-markdown-inline/src")
          (regex "https://github.com/tree-sitter/tree-sitter-regex"
                 "v0.24.3"))))

                                        ;Lisp
(load "~/quicklisp/clhs-use-local.el" 'noerror)
(map! :i "M-[" #'lispy-brackets [])

                                        ; Dap maps
;; (map! :map dap-mode-map
;;       :leader
;;       :prefix ("d" . "dap")
;;       ;; basics
;;       :desc "dap next"          "n" #'dap-next
;;       :desc "dap step in"       "i" #'dap-step-in
;;       :desc "dap step out"      "o" #'dap-step-out
;;       :desc "dap continue"      "c" #'dap-continue
;;       :desc "dap hydra"         "h" #'dap-hydra
;;       :desc "dap debug restart" "r" #'dap-debug-restart
;;       :desc "dap debug"         "s" #'dap-debug

;;       ;; debug
;;       :prefix ("ddr" . "Debug")
;;       :desc "dap debug recent"  "r" #'dap-debug-recent
;;       :desc "dap debug last"    "l" #'dap-debug-last

;;       ;; eval
;;       :prefix ("de" . "Eval")
;;       :desc "eval"                "e" #'dap-eval
;;       :desc "eval region"         "r" #'dap-eval-region
;;       :desc "eval thing at point" "s" #'dap-eval-thing-at-point
;;       :desc "add expression"      "a" #'dap-ui-expressions-add
;;       :desc "remove expression"   "d" #'dap-ui-expressions-remove

;;       :prefix ("db" . "Breakpoint")
;;       :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
;;       :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
;;       :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
;;       :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)


                                        ; Custom Maps

;; Tab
(map! :i "TAB" #'company-indent-or-complete-common)

;; Ctrl maps
(map!
 "C-s" #'evil-write-all)

;; leader maps

(map! :leader

      "j f" #'evil-jump-forward
      "j b" #'evil-jump-backward
      "y t" #'insert-youtube-video-transcript
      "y p" #'yank-from-kill-ring

      "r f c" (generate-bindable-lambda
               (message "resetting recentf-list")
               (setq recentf-list (list)))

      "z" #'+zen/toggle-fullscreen

      "c b" #'blink-cursor-mode

      "b f" #'browse-url-firefox

      "g d i" #'godoc

      "m h t" #'modus-themes-toggle

      "m o i i" #'doom/set-frame-opacity

      "m o l l" (generate-bindable-lambda
                 (doom/set-frame-opacity 20 (list (selected-frame))))

      "m o l m" (generate-bindable-lambda
                 (doom/set-frame-opacity 50 (list (selected-frame))))

      "m o h m" (generate-bindable-lambda
                 (doom/set-frame-opacity 80 (list (selected-frame))))

      "m o h h" (generate-bindable-lambda
                 (doom/set-frame-opacity 95 (list (selected-frame))))

     ;; "m p s" #'python-shell-send-statement
     ;; "m p r" #'python-shell-send-region
     ;; "m p p" #'+python/open-ipython-repl
     ;; "m p f" #'python-shell-send-file
     ;; "m p k" #'python-eldoc-at-point

     ;; "m h h" #'run-hy
     ;; "m h s" #'hy-shell-eval-last-sexp
     ;; "m h r" #'hy-shell-eval-region
     ;; "m h c" #'hy-shell-eval-current-form
     ;; "m h b" #'hy-shell-eval-buffer
     ;; "m h k" #'hy-describe-thing-at-point

      "m c c" #'cider-eval-sexp-at-point
      "m e f" #'cider-eval-file


      "m s t" (generate-bindable-lambda
               (let ((seconds (read-number "SOS in seconds: ")))
                 (call-process-shell-command (format "timer %s" seconds) nil nil nil)))

      "m s f p" (generate-bindable-lambda
                 (let ((port (read-number "Port: ")))
                   (call-process-shell-command (format "firefox http://localhost:%s" port) nil nil nil)))

      "m a h" #'pdf-annot-add-highlight-markup-annotation
      "m a m" #'pdf-annot-add-markup-annotation
      "m a u" #'pdf-annot-add-underline-markup-annotation
      "m a t" #'pdf-annot-add-text-annotation
      "m a x" #'pdf-annot-add-strikeout-markup-annotation
      "m a s" #'pdf-annot-add-squiggly-markup-annotation
      "m a l" #'pdf-annot-list-annotations

      "r s" #'restclient-http-send-current

      "w w" #'switch-window

      "e x" #'eros-eval-defun

      "l h" #'life-hex-count

      "l t" (generate-bindable-lambda
             (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

      "l l" (generate-bindable-lambda
             (insert "[")
             (life-hex-count)
             (insert "|" (format-time-string "%s"))
             (insert " ]"))

      "o g w" #'gtd-workspace
      "o g a" #'gtd-workspace-archive

      "e h s b"  (generate-bindable-lambda
                  (find-file "STATE-BIT-MAGE-DIR/content/scroll/index.md"))

      "e h b" (generate-bindable-lambda
               (setq easy-hugo-basedir  STATE-BIT-MAGE-DIR
                     easy-hugo-postdir "content/post/")
               (easy-hugo))

      "e h s c" (generate-bindable-lambda
                 (find-file "STATE-COGNWARE-DIR/content/scroll/index.md")) 

      "e h c" (generate-bindable-lambda
               (setq easy-hugo-basedir  "STATE-COGNWARE-DIR"
                     easy-hugo-postdir "content/posts/")
               (easy-hugo))

      "e h m t" (generate-bindable-lambda
                 (insert "#### ")
                 (insert "[")
                 (life-hex-count)
                 (insert "|" (format-time-string "%s"))
                 (insert " ]\n")
                 (insert "```\n```")
                 (evil-open-above 0))

      "t t" #'tldr

      "X" #'scratch-buffer

      "s w" #'eww
      "e w" #'eww-switch-to-buffer
      "e u" #'eww-open-in-new-buffer
      "e c" #'eww-copy-page-url

      "n i l" #'org-insert-link
      "c e" #'org-cite-insert
      "c o" #'citar-open
      "c d" #'citar-dwim

      "n r v a" #'nth-roam-select-vault
      "n r v v" #'nth-roam-yield-current-vault
      "n r v d" #'nth-roam-doctor

      "n r u u" #'org-roam-ui-open
      "n r u z" (generate-bindable-lambda
                 (org-roam-ui-node-zoom (org-roam-id-at-point)
                                        100
                                        100))
      "n r u f f" #'org-roam-ui-follow-mode
      "n r u l l" (generate-bindable-lambda
                   (org-roam-ui-node-local (org-roam-id-at-point)
                                           100
                                           20))

      "n r u l c" #'org-roam-ui-change-local-graph
      "n r u l a" #'org-roam-ui-add-to-local-graph
      "n r u l d" #'org-roam-ui-remove-from-local-graph


      "n r u l c" #'org-roam-ui-change-local-graph
      "n r u l a" #'org-roam-ui-add-to-local-graph
      "n r u l d" #'org-roam-ui-remove-from-local-graph
      "n r u l g" #'org-roam-ui-local-graph
      "n r u g g" #'org-roam-ui-global-graph


      "m d h" #'shortdoc


      "m c t t" #'copilot-mode

      "m c p h" #'mcp-hub
      "m c p g" #'gptel-mcp-dispatch

      "i c a" #'eca-transient-menu

      "i p" #'pi-coding-agent
      "i P" #'pi-coding-agent-toggle

      "i g h" #'gptel
      "i g s" #'gptel-send
      "i g m" #'gptel-menu
      "i g x" #'gptel-abort

      "i w r" #'whisper-run
      "i w f" #'whisper-file
      "i w l" #'whisper-select-language

      ;;"i g f f" #'fabric-gpt.el-send
      ;;"i g f s" #'fabric-gpt.el-sync-patterns
      "i g a p" #'gptel-prompt-alter
      "i g a s" #'dispatch-ephemeral-gptel-base-send
      
      "i g p s" #'sanitize-perplexity-citations

      "i g a J o" (gptel-prompt-lambda "Outline" "*:Jargonize"))


;; .. the home row ..
(map! :map evil-insert-state-map
      :prefix "C-M-i"
      "q" (generate-bindable-lambda (insert "`"))
      "w" (generate-bindable-lambda (insert "~"))
      "f" (generate-bindable-lambda (insert "%"))
      "d" (generate-bindable-lambda (insert "$"))
      "h" (generate-bindable-lambda (insert "#"))
      "m" (generate-bindable-lambda (insert "*"))
      "r" (generate-bindable-lambda (insert "@"))
      "a" (generate-bindable-lambda (insert "&"))
      "o" (generate-bindable-lambda (insert "!"))
      "p" (generate-bindable-lambda (insert "+"))
      "c" (generate-bindable-lambda (insert "^"))
      "n" (generate-bindable-lambda (insert "-"))
      "u" (generate-bindable-lambda (insert "_"))
      "e" (generate-bindable-lambda (insert "=")))

(after! eshell
  (map! :map eshell-mode-map
        "C-M-h c s" (generate-bindable-lambda (eshell/clear-scrollback))))

(after! evil
  (map! :map evil-normal-state-map
        "C-M-s" (generate-bindable-lambda
                 (evil-ex "r!date"))
        "C-M-k" (generate-bindable-lambda (ultra-scroll-up (/  (window-pixel-height) 8)))
        "C-M-j" (generate-bindable-lambda (ultra-scroll-down (/  (window-pixel-height) 8)))))

(after! hy-mode
  (map! :map hy-mode-map
        "C-M-h r i" (generate-bindable-lambda (insert "#/ "))
        "C-M-h r l" (generate-bindable-lambda (insert "#%"))
        "C-M-h r a" (generate-bindable-lambda (insert "#^ "))))


;; obs
(keymap-unset
 global-map
 "C-M-q")

(keymap-unset
 global-map
 "C-M-SPC")
