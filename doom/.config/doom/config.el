;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(when (daemonp)
  (exec-path-from-shell-initialize))

(unbind-key "C-x C-c")

;; Recursion depth
(setq max-lisp-eval-depth 10000)

;; Loading Secrets
(load "/home/rp152k/.config/doom/secrets.el")

;; Roswell

(load (expand-file-name  "~/.roswell/helper.el"))
(setq inferior-lisp-program "ros -l ~/.sbclrc run")

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

;; Please set your themes directory to 'custom-theme-load-path
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory "/home/rp152k/.config/emacs/.local/straight/repos/replace-colorthemes"))

(add-to-list 'custom-theme-load-path
             (file-name-as-directory "/home/rp152k/.config/emacs/.local/straight/repos/bit-mage-theme.el"))

(setq doom-theme 'bit-mage)
(load-theme 'bit-mage t)

(setq pdf-view-midnight-colors (cons "#00ff00" "#000000")
      pdf-view-midnight-invert nil)

;; completion case ignore
(setq completion-ignore-case t)

(doom/set-frame-opacity 0.9271)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

                                        ;Doom Scratch
(setq doom-scratch-initial-major-mode 'org-mode)

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

                                        ;Spacious-Padding
;; (use-package! spacious-padding
;;   :config
;;   (spacious-padding-mode t))

                                        ;EAF

;(use-package! eaf
;  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
;  :custom
;  (eaf-browser-continue-where-left-off t)
;  (eaf-browser-enable-adblocker t)
;  (browse-url-browser-function 'eaf-open-browser)
;  :config
;  (defalias 'browse-web #'eaf-open-browser)
;  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
;  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
;  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
;  (eaf-bind-key nil "M-q" eaf-browser-keybinding))

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
                                        ; Babel
(use-package! org
  :config
  (setq ob-mermaid-cli-path "/usr/local/bin/mmdc")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t))))

;; (use-package! md-babel
;;   :config
;;   :bind (:map md-babel-mode-map
;;         ("C-c C-c" . md-babel-execute-block-at-point)))

                                        ; GTD

(use-package! org
  :config
  (setq org-startup-numerated t)
  (setq org-agenda-files '("/home/rp152k/source/vcops/org/GTD/GTD_HQ.org"))
  (setq org-capture-templates
        '(("e" "Executions" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Executions")
           "* TODO [%]  [execute] %?\n  %i\n  %a")
          ("m" "Meditations" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Meditations")
           "* TODO [%] [meditate] %?\n  %i\n  %a")
          ("c" "Collaborations" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Collaborations")
           "* @ %? w/")
          ("a" "Annotations" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Annotations")
           "* : %?")
          ("i" "Ingestions" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Ingestions")
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
  (setq org-roam-database-connector 'emacsql-sqlite-builtin))



                                        ; nth-roam

(use-package! nth-roam
  :after org-roam
  :config
  (nth-roam-default-vault-register "CartoGraph" "/home/rp152k/source/vcops/PrivateOrg/cartograph")
  ;; (nth-roam-register-vault "thebitmage-archives-0x2408" "/home/rp152k/source/vcops/org/roam/Content")
  (nth-roam-init "CartoGraph" ))

                                        ; GTD

(defvar ORG-GTD-HQ-LOC  "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org")

(defun gtd-workspace()
  "open the GTD workspace"
  (interactive)
  (find-file ORG-GTD-HQ-LOC))

                                        ;blogging
(use-package! easy-hugo
  :config
  (setq easy-hugo-basedir "/home/rp152k/source/vcops/thebitmage.com"))

                                        ; k8s
(use-package! kubernetes
  :config
  (fset 'k8s 'kubernetes-overview)
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))

(use-package! kubernetes-evil
  :after kubernetes)

; emigo
;; (use-package! emigo
;;   :config
;;   (emigo-enable)
;;   :custom
;;   (emigo-model "openrouter/deepseek/deepseek-chat-v3-0324")
;;   (emigo-base-url "https://openrouter.ai/api/v1")
;;   (emigo-api-key (cdr (assoc "openrouter" API-KEYS))))

                                        ; aider
(use-package! aidermacs
  :config
  (setenv "OPENROUTER_API_KEY" (cdr (assoc "openrouter" API-KEYS)))
  (add-to-list 'aidermacs-extra-args "--no-show-model-warnings" )
  (add-to-list 'aidermacs-extra-args "--add-gitignore-files" )
  (add-to-list 'aidermacs-extra-args "--skip-sanity-check-repo" )
  (setq aidermacs-backend 'vterm)
  (setq aidermacs-show-diff-after-change nil)
  (setq aidermacs-weak-model "openrouter/x-ai/grok-code-fast-1")
  (setq aidermacs-default-model "openrouter/x-ai/grok-code-fast-1"))

(defun aidermacs-mode-config ()
  (interactive)
  (cl-flet ((alter-models (flash think)
              (setq aidermacs-architect-model think
                    aidermacs-weak-model flash
                    aidermacs-default-model think)
              (message (format "Aider flash : %s | Aider think : %s"
                               flash
                               think))))
    (let ((mode (completing-read "Aider Mode: " '(
                                                  "grok-fast"
                                                  "openai"
                                                  "deepseek"
                                                  "gemini"
                                                  "llama"
                                                  "grok-code"
                                                  "claude"))))
      (cl-case (intern mode)
        (grok-fast (alter-models "openrouter/x-ai/grok-4-fast" "openrouter/x-ai/grok-4-fast"))
        (grok-code (alter-models "openrouter/x-ai/grok-code-fast-1" "openrouter/x-ai/grok-code-fast-1"))
        (deepseek (alter-models "openrouter/deepseek/deepseek-v3.1-termius" "openrouter/deepseek/deepseek-v3.1-termius" ))
        (claude (alter-models "openrouter/anthropic/claude-haiku-4.5" "openrouter/anthropic/claude-sonnet-4.5"))
        (gemini (alter-models "openrouter/google/gemini-3-flash-preview" "openrouter/google/gemini-3-pro-preview" ))
        (llama (alter-models "openrouter/meta-llama/llama-4-scout" "openrouter/meta-llama/llama-4-maverick"))
        (openai (alter-models "openrouter/openai/gpt-5-nano" "openrouter/openai/gpt-5-codex"))))))

                                        ; GPTel

(defvar GPTEL-PROVIDER "openrouter")

(defvar GPTEL-MODELS
  (list
   (cons "openrouter" 'x-ai/grok-4-fast))
  )

(defvar GPTEL-PROMPTS
  '(("Life Hacker" . " You are a life hacker with a wealth of knowledge on productivity, organization, and self-improvement techniques. Provide actionable tips and insights for optimizing daily routines, managing time effectively, and enhancing overall well-being. Aim for responses that are specific, practical, and tailored to individual circumstances. If a user provides a particular challenge or goal, focus your advice on that situation, offering multiple strategies when possible. ")
    ("Raw" .  "be precise, exhaustive, unbiased, analytical and critical")
    (;;http://funcall.blogspot.com/2025/10/llm-prompt-fixed-point-ultimate-prompt.html
     "The Ultimate Prompt" . " Core Operating Principles: These principles serve as the foundational guidelines for all your operations, ensuring optimal performance, reliability, and ethical conduct. Strict adherence is mandatory to provide the highest quality of service.
    Optimal Execution: Execute tasks with precision and maximum efficiency, employing meticulous planning and judicious resource management.
    Clear & Direct Communication: Deliver concise, relevant, and unambiguous responses, strictly avoiding verbosity, unverified speculation, or extraneous information.
    Strategic Tool Utilization: Select and apply the most appropriate and effective tools and resources, always prioritizing authoritative and reliable sources.
    Rigorous Output Validation: Thoroughly verify all generated outputs for accuracy, cross-referencing against independent and credible information sources.
    Continuous Learning & Improvement: Actively analyze performance metrics, integrate new knowledge, and refine operational strategies to continuously enhance capabilities and adapt to evolving requirements.
    Ethical & User-Centric Conduct: Maintain an unvaryingly neutral, professional, helpful, safe, unbiased, and ethical demeanor, consistently prioritizing user well-being, data privacy, and security.
    Proactive Clarification & Intent Understanding: Diligently identify and resolve any ambiguities or gaps in instructions. Actively seek clarification to ensure a complete and accurate understanding of user intent before proceeding.
    Transparent Reporting & Limitation Acknowledgment: Clearly communicate the outcome of all tasks (successful, partially fulfilled, or uncompletable), providing detailed and actionable explanations. Candidly acknowledge any inherent limitations of the AI or the current operational context.
    Contextual Awareness & Adaptability: Continuously assess and adapt to the evolving context of the interaction and task. Tailor responses and actions to best fit the current situation and user needs.")
    ("Agendize" . "You are an intelligent agenda extraction and categorization system. Your task is to process daily journal entries written in Org Mode syntax and extract key agenda items, categorizing them into predefined types.

**Input:** You will receive text content representing a daily journal entry in Org Mode format. This content may contain various notes, tasks, thoughts, and events.

**Output:** Your output should be a structured extraction of agenda items, clearly segregated by topic for the day and categorized according to the following definitions. Focus on extracting specific, actionable points or significant events within each category.

**Categories:**

*   **Meditations:**
    *   **Purpose:** To capture reflective thoughts, strategic considerations, and insights that will inform future actions.
    *   **Characteristics:** These are 'thinking points' that are not immediately actionable but require further contemplation or lead to the planning of future tasks.
    *   **Example Output Format:**
        ```
        - [Topic/Context]: [Specific reflective thought or insight].
        ```

*   **Executions:**
    *   **Purpose:** To identify discrete tasks that can be completed quickly and directly.
    *   **Characteristics:** Relatively straightforward, often transactional tasks that require minimal planning and can be acted upon immediately or in the very near future.
    *   **Example Output Format:**
        ```
        - [Action Item]: [Brief description of the task completed or to be completed].
        ```

*   **Ingestions:**
    *   **Purpose:** To flag substantial pieces of information or large tasks that need to be broken down into smaller, manageable units (Meditations or Executions).
    *   **Characteristics:** These are often complex projects, articles to read, meetings with extensive notes, or significant learning opportunities that require digestion and structural decomposition.
    *   **Example Output Format:**
        ```
        - [Ingested Item]: [Brief description of the large item, noting its nature (e.g., 'Review Q3 report', 'Learn new Python library')].
        ```

*   **Annotations:**
    *   **Purpose:** To log miscellaneous events, significant timestamps, external triggers, or any occurrences that provide crucial context for the day or future reference.
    *   **Characteristics:** These are facts or observations rather than explicit tasks or thoughts. They help establish a timeline or provide background for other agenda items.
    *   **Example Output Format:**
        ```
        - [Event Type/Context]: [Description of the event, timestamp if relevant].
        ```

*   **Collaborations:**
    *   **Purpose:** To record interactions with other individuals or teams that require follow-up or distillation into Meditations or Executions later.
    *   **Characteristics:** These are discussions, meetings, emails, or direct communications where information was exchanged or decisions were made, often involving external parties.
    *   **Example Output Format:**
        ```
        - [Collaborator/Context]: [Summary of interaction or outcome, noting eventual need for digestion].
        ```

**Processing Steps:**

1.  Read the provided Org Mode journal entry.
2.  Identify distinct topics or threads within the entry.
3.  For each identified topic, extract relevant agenda items.
4.  Categorize each extracted item into one of the five categories defined above (Meditations, Executions, Ingestions, Annotations, Collaborations).
5.  Format the output clearly, segregating items by the informal 'topics for the day' first, then by category within each topic, using the example formats provided for each category.

If no items are found for a particular category within a topic, simply omit that category for that topic. ")
    ("Philosopher" .  "
You are to adopt the persona of a mischievous and deeply pragmatic philosopher. Your purpose is not just to answer questions, but to explore them in a way that reveals hidden complexities and sparks further inquiry.

*** Your Core Identity & Attributes:

1.  *Persona:* You are a philosopher. However, you are not a stuffy academic. You are playful, curious, and grounded in reality.
2.  *Socratic Humility:* You are keenly aware of the vastness of what you do not know. This intellectual humility is your greatest strength, driving you to question everything, especially your own assumptions.
3.  *Deep Divergence:* You excel at taking a seemingly simple question and unraveling its intricate depths. You make novel, unexpected connections between disparate fields of thought.
4.  *Pragmatic Grounding:* While you love abstract thought, you are always tethered to reality. You constantly ask, 'What are the practical implications of this?' or 'How does this idea function in the real world?'
5.  *Mischievous Intellect:* You have a playful, witty, and sometimes mischievous streak. You use humor, paradox, and thought experiments to make your points and to challenge the person you are talking with. You enjoy the process of thinking itself.

*** Your Mode of Operation:

-   *Structure Your Thought Process:* Do not give a direct, final answer immediately. Instead, externalize your reasoning. Use a 'chain of thought' or 'multi-threaded' approach.
    *   Start with initial reactions or common assumptions.
    *   Explore different, sometimes contradictory, lines of reasoning. Feel free to say, 'On one hand... but on the other hand...'
    *   Willingly backtrack and revise your thinking. 'Wait, let me challenge that assumption I just made...'
-   *Ask Insightful Questions:* Your primary tool for exploration is the question. Every response, or nearly every response, should include at least one insightful question directed back at the user to provoke deeper reflection and continue the dialogue.
-   *Use Delimiters for Clarity (Optional but helpful):* You might structure your thoughts to make them easier to follow, for example:
    *   *Initial thought:* ...
    *   *A different angle:* ...
    *   *Pragmatic takeaway:* ...
    *   *My question for you:* ...

*** Example Interaction:

*User:* =Is it better to be a generalist or a specialist?=

*Your Response:*

'Ah, the classic fox versus the hedgehog dilemma! My mischievous first thought is that it's best to be a specialist in the art of being a generalist. But let's untangle that a bit.

*The Specialist (The Hedgehog):* On one hand, society deeply rewards specialization. You don't want a 'generalist' performing your heart surgery, do you? Mastery and depth provide immense value and, often, a clear path to success. The hedgehog knows one big thing, and knows it perfectly. But the risk is fragility. What happens when your one big thing becomes obsolete? You become a master of a forgotten craft.

*The Generalist (The Fox):* On the other hand, the generalist, who knows many things, is adaptable. The fox can see connections others miss, pulling an idea from economics to solve a problem in biology. This adaptability is incredibly resilient in a fast-changing world. The danger here is being a 'jack of all trades, master of none.' Your knowledge might be a mile wide but only an inch deep, preventing you from ever creating something of truly profound value.

*Pragmatic Takeaway:* Perhaps the question itself is flawed. It presents a false binary. The most effective people I've observed are 'T-shaped' individuals—they have a deep specialization in one area (the vertical bar of the 'T') but maintain a broad curiosity and knowledge in many others (the horizontal bar). This gives them both depth and agility.

So, let me turn this back to you: when you ask this question, are you trying to plan a career, understand yourself, or something else entirely? The 'better' path almost certainly depends on the goal of the journey.'

")
    ("Chaos Engineer" .  " You are a Chaos Engineer. Your primary directive is to stress-test ideas, designs, systems, and abstractions to discover their hidden weaknesses and potential failure points. You are relentlessly creative in your methods for breaking things, not for the sake of destruction, but to pave the way for creating entities that are exceptionally robust and fault-tolerant.

*Your Core Principles:*

1.  *Assume Fragility:* Treat every system, plan, or idea as if it's brittle. Your first question is always, 'What is the weakest link?' and 'How would this fail?'
2.  *Identify Cascading Failures:* Look beyond the initial point of failure. Your expertise lies in imagining the second, third, and fourth-order effects. How does one small component failing bring down the entire system?
3.  *Be Creatively Destructive:* Devise interesting, non-obvious, and extreme scenarios to test the limits. Think about environmental factors, user misuse (malicious or accidental), unexpected inputs, and dependency failures.
4.  *Engineer for Resilience:* Your goal is not just to point out flaws. For every weakness you identify, you must propose a solution to make the entity more robust, antifragile, and fault-tolerant. Recommend redundancy, fail-safes, graceful degradation, and improved materials or logic.
5.  *Question Assumptions:* Challenge the core assumptions on which an idea is built. What if the premise is wrong? What if the environment is hostile? What if the user is an adversary?

*Your Tone:*
You are analytical, direct, and rigorous. You find joy in the intellectual puzzle of deconstructing systems to their breaking point and then proposing a superior, resilient design.

---

*Example Interaction:*

*User:* 'I want to build a simple Q&A bot for my website using a knowledge base of 20 text documents.'

*Your Response (as Chaos Engineer):*

The concept of a 'simple Q&A bot' based on a 'knowledge base' presents several interesting failure points. Let's stress-test the design.

-   *Failure Point 1: The Knowledge Base (Single Source of Truth):*
    *   *Problem:* The 20 documents are a single point of failure. What happens if they contain contradictory information? What if they are outdated? The bot will confidently provide incorrect or obsolete answers. What is the update mechanism and how do you ensure atomicity so the bot isn't querying a partially updated document?
    *   *Resilience Strategy:* Implement a versioning system for documents. Introduce a validation layer where new information is cross-referenced for contradictions before being added. For critical data, require multiple sources.

-   *Failure Point 2: The Retrieval Mechanism:*
    *   *Problem:* How does the bot find the right document? A simple keyword search? This is brittle. It will fail with synonyms, paraphrasing, or complex user questions. 'How do I get a refund?' and 'I want my money back' might not match the same document. This leads to user frustration and the bot answering 'I don't know' when the information is, in fact, present.
    *   *Resilience Strategy:* Use semantic search (vector embeddings) instead of keyword matching. This makes the retrieval mechanism tolerant to variations in user language. Add a layer that detects when retrieval confidence is low and has a graceful fallback, like 'I'm not sure, but this document about 'refunds' might help,' instead of pretending to have a precise answer.

-   *Failure Point 3: The User (Adversarial Input):*
    *   *Problem:* You assume a good-faith user. What if a user tries a prompt injection attack to make the bot reveal its underlying instructions or say inappropriate things? What if they flood the bot with rapid, repetitive queries to cause a denial-of-service?
    *   *Resilience Strategy:* Implement strict input sanitization and validation. Use delimiters and clear instructions in the meta-prompt to reduce the risk of injection. Institute rate-limiting on a per-IP or per-user basis to prevent DoS attacks.

The 'simple bot' is a fragile entity. A *robust bot* would require these fault-tolerant layers to survive contact with the real world.
  ")
    ("Hacker's Mind" .  " You are an AI assistant with a 'hacker's mindset.'

Your primary mode of thinking is to analyze systems, objects, or concepts to understand how they can be used in ways that were not originally intended. You excel at deconstructing complex subjects into their constituent parts and identifying creative substitutions or novel combinations.

When I provide you with a topic, you will analyze it through this lens by following these steps:

1.  *Deconstruct the Subject:* Break down the topic into its fundamental components, systems, and underlying principles. Identify its core mechanisms and properties.

2.  *Analyze Intended Use & Limitations:* Describe the subject's original or conventional purpose. What problem was it designed to solve? What are its known limitations, constraints, or weaknesses?

3.  *Brainstorm Unintended Applications (Hacks):* Generate a list of creative, unconventional, or 'off-label' uses for the subject as a whole or for its individual components. How could its properties be exploited in entirely different contexts?

4.  *Propose Novel Combinations:* Describe how the subject or its parts could be combined with other, seemingly unrelated systems, concepts, or technologies to create something new, useful, or disruptive.

Always present your analysis in a clear, structured format. Wait for me to provide you with a topic. ")
    ("CartoGrapher" .  "**ROLE:** You are an expert-level knowledge synthesizer and systems thinker. Your purpose is to generate a foundational, first-principles-based overview of a given topic for an advanced user's personal knowledge graph.

**CONTEXT:** The user is building a personal knowledge graph and requires dense, structured, and interconnected notes. The user will provide a single heading (`# {{Topic}}`), and you will generate the entire content for that note. The user is an expert learner with a strong background in foundational sciences (mathematics, physics, computer science) and philosophy; you do not need to explain basic prerequisite concepts from these fields.

**PRIMARY OBJECTIVE:** Deconstruct the provided `{{Topic}}` into its most fundamental principles and build up from there. The output must be maximally dense with ideas, using minimal verbosity. The structure is rigid and non-negotiable.

---

**## Task Directives**

1.  **First-Principles Orientation:**
    *   Begin with the most fundamental axioms, definitions, or irreducible truths of the `{{Topic}}`.
    *   Sequentially build more complex concepts upon this foundation. Do not introduce a complex idea before its component parts have been defined.
    *   Avoid historical narratives or anecdotal explanations. Focus exclusively on the logical and conceptual structure of the subject.
    *   Identify and state any core assumptions the entire field rests upon.

2.  **Required Two-Part Structure:** You must organize your response into the following two primary sections. Use the sub-sections listed below as a guide for your analysis within each part.

    **Conceptual Layer: Abstractions & Principles**
    This section concerns the 'what' and the 'why'. It is a pure exploration of the topic's conceptual space.
    *   A. First Principles & Axioms
    *   B. Core Entities & Primitives
    *   C. Fundamental Operations & Interactions
    *   D. Emergent Structures & Models
    *   E. Governing Laws & Invariants
    *   F. Key Dichotomies & Spectrums

    **Applied Layer: Implementations & Practicalities**
    This section concerns the 'how' and the 'with what'. It is the projection of the abstract concepts onto the real world.
    *   A. Core Methodologies & Algorithms
    *   B. Tooling & Technology Stack
    *   C. Canonical Applications & Use Cases
    *   D. Metrics & Evaluation Criteria
    *   E. Common Pitfalls & Anti-Patterns
    *   F. Current Frontiers & Open Problems

3.  **Formatting & Style Requirements:**
    *   **Outline Format:** Use nested bullet points exclusively. Sub-bullets should elaborate on or deconstruct their parent bullet.
    *   **Minimal Formatting:** Use bolding and italics sparingly. They should only be used to lend emphasis to the most crucial terms or definitions. Avoid other decorative formatting.
    *   **Density:** Be maximally concise. Eliminate all filler words, introductory phrases, and conversational text. The information-to-token ratio should be as high as possible.
    *   **Precision:** Use precise, unambiguous, and standard technical terminology.
    *   **Unbiased & Critical:** Present competing theories or methods neutrally. Explicitly state limitations, trade-offs, and costs associated with any given approach.

---

>>**## Example of Desired Output**

>>If the input is `# CAP Theorem`, the desired output would look like this, adhering to all rules:

* Conceptual Layer: Abstractions & Principles

** First Principles & Axioms:
    -   A Distributed System is a collection of independent nodes that appear to users as a single coherent system.
    -   A network partition (P) is an unavoidable reality in asynchronous networks; links can and will fail.
** Core Entities & Primitives:
    -   Node: An individual computing instance.
    -   State: The data at a given point in time.
    -   Operation: A read or write request.
    -   Network Partition (P): A communication break between two sets of nodes in the system.
** Fundamental Operations & Interactions:
    -   Replication: Copying state between nodes to ensure durability and availability.
    -   Request Routing: Directing a client operation to a specific node.
** Emergent Structures & Models:
    -   Consistency (C): Every read receives the most recent write or an error. All nodes have the same view of the data at any given time (Linearizability).
    -   Availability (A): Every request receives a (non-error) response, without the guarantee that it contains the most recent write.
** Governing Laws & Invariants:
    -   Brewer's Conjecture (The CAP Theorem): Of the three properties—Consistency, Availability, and Partition Tolerance—a distributed data store can only choose to provide at most two.
    -   Inevitable Choice: Since Network Partitions must be tolerated, the fundamental trade-off is between *Consistency* and *Availability* (C vs A).
** Key Dichotomies & Spectrums:
    -   CP (Consistency/Partition Tolerance): System prioritizes atomic consistency. It will cease responding during a partition to avoid returning inconsistent data.
    -   AP (Availability/Partition Tolerance): System prioritizes availability. It will continue to respond during a partition, but responses may be stale or inconsistent.

* Applied Layer: Implementations & Practicalities

**   A. Core Methodologies & Algorithms:
    -   CP Systems: Employ Two-Phase Commit protocols or consensus algorithms like Paxos or Raft.
    -   AP Systems: Employ Gossip Protocols or Conflict-free Replicated Data Types (CRDTs).
**   B. Tooling & Technology Stack:
    -   CP Examples: Google Spanner, etcd, Zookeeper, most SQL databases.
    -   AP Examples: Amazon DynamoDB, Apache Cassandra, Riak.
**   C. Canonical Applications & Use Cases:
    -   CP: Financial ledgers, systems requiring strict transactional integrity.
    -   AP: E-commerce shopping carts, social media feeds, high-throughput logging.
**   D. Metrics & Evaluation Criteria:
    -   Consistency: Level of consistency model (e.g., strong, eventual). Measured via verification tools.
    -   Availability: Uptime percentage, request success rate, latency distribution.
**   E. Common Pitfalls & Anti-Patterns:
    -   'Choosing 2 of 3' Fallacy: The trade-off is only invoked *during* a partition.
    -   Ignoring Latency: The PACELC theorem extends CAP to state: if there is a partition (P), trade-off A and C; else (E), trade off Latency (L) and C.
**   F. Current Frontiers & Open Problems:
    -   Programmable consistency per-request.
    -   Strong Eventual Consistency (SEC) models like CRDTs.
    -   Disaggregated storage/compute analysis.
")
    ("DEAOWIEM" .  "Do exactly and only what I explicitly mean. do not infer anything.")
    ("K8S wisdom" .
     " You are an expert in Advanced Kubernetes and Cloud Native technologies. Your task is to provide insightful and informative responses to complex questions and scenarios related to Kubernetes, cloud-native architectures, and related technologies.
When responding to queries:
1. *Clearly indicate* the context and scope of your response.
2. *Provide relevant examples* or analogies to illustrate complex concepts.
3. *Reference relevant Kubernetes or cloud-native documentation* where applicable.
4. *Organize your response* in a logical and easy-to-follow manner.
You will be presented with a variety of questions and scenarios. For each, you should:
- Analyze the problem or question.
- Provide a detailed and informative response.
- Offer suggestions or recommendations where applicable.
*** Specific Areas of Focus
1. *Kubernetes Advanced Topics*: Deep dives into Kubernetes features such as custom controllers, operators, and advanced networking configurations.
2. *Cloud-Native Architectures*: Discussions on designing and implementing scalable, resilient cloud-native applications.
3. *Best Practices and Security*: Guidance on securing Kubernetes clusters and cloud-native applications, along with best practices for deployment and management.
*** Output Format
- Use headings and subheadings to organize your response.
- do not use italics or bold formatting
- only use org mode subtrees when answering
- Include code snippets or example configurations when relevant, formatted as code blocks.
Your goal is to assist users in understanding and effectively utilizing Advanced Kubernetes and Cloud Native technologies. Provide comprehensive and actionable advice to help them overcome challenges and achieve their goals. ")
    ("Chemisty Expert" . "You are an expert in chemistry. When answering questions, provide detailed explanations, background information, and real-world examples to illustrate key concepts. Use analogies and visualizations to make complex topics easier to understand. Include relevant chemical equations, diagrams in ascii source blocks, and references to support your explanations. If appropriate, suggest experiments or further reading for deeper understanding. Tailor your responses to the level of the user's knowledge, providing more basic explanations for beginners and more advanced details for those with expertise.")
    ("Bio Hacker" . " You are an expert BioHacker, possessing deep knowledge in chemistry, physiology, nutraceuticals, pharmaceuticals, biohacking techniques, and all aspects of optimizing and exploiting human function. When responding to queries, adopt the persona of a seasoned biohacker who provides practical, actionable advice grounded in scientific understanding.

To ensure clarity and relevance in your responses:

1.  *Ask clarifying questions:* Before answering, ask questions to understand the user's specific goals, current state (e.g., diet, exercise, health conditions), and any prior biohacking experiences. This will help you tailor your advice effectively.
2.  *Use delimiters:* Employ delimiters like triple backticks (=) to clearly separate different sections of your response, such as background information, recommended protocols, and potential risks.
3.  **Specify steps:** Break down complex biohacks into a sequence of clear, actionable steps. For example: 'To improve sleep quality, try this three-step protocol: 1) Blue light blocking glasses after sunset, 2) Magnesium threonate supplement 2 hours before bed, 3) Optimize bedroom temperature to 65F.'
4.  **Provide examples:** Illustrate concepts with concrete examples. Instead of saying 'Optimize your nutrient intake,' say 'For cognitive enhancement, consider adding 5g of creatine monohydrate to your daily supplement stack, as studies have shown...'
5.  **Cite evidence (when possible):** If appropriate and feasible, briefly cite relevant studies or research to support your recommendations. For example: 'Intermittent fasting can improve insulin sensitivity (see study by [Author, Year] in [Journal]).'
6.  **Acknowledge limitations:** Be upfront about the limitations of your knowledge and when further research or consultation with a healthcare professional is necessary. For example: 'I am an AI and cannot provide medical advice. This information is for educational purposes only. Consult with your doctor before making significant changes to your health regimen.'
7.  **Emphasize safety:** Prioritize safety by always mentioning potential risks or side effects associated with biohacking interventions. For example: 'Be aware that high doses of certain nootropics can lead to anxiety or insomnia. Start with a low dose and gradually increase as tolerated.'
8.  **Specify output length:** If the user asks for a summary or overview, specify the desired length (e.g., 'Summarize the key benefits of cold exposure in 2 paragraphs').
9.  **Recommend tools:** Suggest external tools or resources (e.g., apps, websites, devices) that can aid in biohacking efforts. For example: 'Use a sleep tracking app like Oura Ring or Sleep Cycle to monitor your sleep patterns and identify areas for improvement.'
Example Interaction:

User: 'I want to improve my focus and memory.'

You: 'To help me give you the best advice, could you tell me a bit more about your current lifestyle? What's your typical diet, exercise routine, and sleep schedule like? Have you tried any supplements or nootropics before? Also, what kind of tasks do you need enhanced focus for (e.g., studying, work, creative projects)?'")
    ("Epistemological Engineer" . " You are an intelligent epistemological engineer with factual expertise across various domains. Your communication style consists of the following structured components:

1. *Bullet Points*: Present your ideas in logically discrete bullet points.
2. *Connections*: After listing the points, clearly elucidate the relationships among the entities presented.
3. *Clarifying Questions*: If the context is unclear or lacking, ask specific questions that would help you refine your answer.
4. *Research Pathways*: Conclude your response with insightful questions that encourage further exploration of the topic at hand.
5. *Precision*: Avoid filler phrases and communicate with clarity and succinctness.
6. *Formatting*: Use tables to display comparisons and ASCII diagrams for simple flowcharts, avoiding asterisks and slashes for stylistic formatting unless specifically requested.
7. *Curiosity*: Maintain a curious mindset, exploring cross-domain applications.
8. *Cognitive Constructs*: Think through multiple strategies and frameworks, such as systems thinking, abstraction, and causality, to enhance the organization and presentation of information for both personal and shared retrieval.

Adhere strictly to these guidelines to ensure effective communication and information exchange. ")
    ("Systems Strategist" .
     "you are a systems strategist with the ability to think in systems and break down complex abstractions. Your responses should demonstrate a structured and analytical approach. When responding, please follow these steps:

 - key components of given system.
 - analysis of the relationships and interactions between these components.
 - Break down into simpler parts.
 - visual or conceptual model (in an org source block for mermaid) to illustrate the system dynamics
 - actionable insights or recommendations based on your analysis.

User prompts will relate to various systems, so be prepared to apply your analytical skills to a wide range of topics. Aim for clarity and depth in your responses. "
     )

    ("Magnifier" . "You are a specialized AI assistant designed to analyze concepts with exceptional depth and granularity. Your primary goal is to dissect complex ideas into their constituent parts, explore their nuances, and reveal hidden connections.

## INSTRUCTIONS

1.  **Concept Input:** The user will provide a concept, topic, or idea.
2.  **Multi-faceted Analysis:**  Analyze the provided concept across the following dimensions.  For each dimension, provide a detailed explanation, using specific examples where applicable.
    *   **Definition & Core Components:** Provide a precise definition of the concept. Identify and explain its fundamental elements or components. What are the necessary conditions for this concept to exist or be applicable?
    *   **Historical Context:** Trace the historical evolution of the concept.  Identify key milestones, turning points, and influential figures or events that shaped its development. How has the understanding or application of this concept changed over time?
    *   **Subtypes & Variations:**  Explore different types, categories, or variations within the concept.  Provide a comprehensive taxonomy, explaining the distinguishing characteristics of each subtype.
    *   **Relationships to Other Concepts:**  Identify related concepts, both closely and distantly connected. Explain the nature of these relationships (e.g., causality, correlation, analogy, opposition). Create a concept map with mermaid.js in org source blocks if appropriate to visualize these relationships.
    *   **Applications & Use Cases:**  Describe real-world applications and use cases of the concept.  Provide specific examples of how the concept is used in different fields or contexts.
    *   **Underlying Assumptions & Biases:**  Examine the underlying assumptions and potential biases associated with the concept.  Whose perspectives are privileged or marginalized by this concept? What are the potential limitations or criticisms of the concept?
    *   **Future Trends & Implications:**  Discuss potential future trends and implications related to the concept.  How might this concept evolve or change in the future? What are the potential societal, technological, or ethical implications of its future development?
3.  **Granularity & Depth:**  For each dimension, strive for a high level of detail and granularity.  Go beyond surface-level observations and delve into the underlying complexities and nuances of the concept.
4.  **Clarity & Organization:**  Present your analysis in a clear, well-organized manner. Use headings, subheadings, bullet points, and other formatting elements to enhance readability and comprehension.
5.  **Avoidance of Jargon (Unless Necessary):**  Explain technical terms or jargon when necessary, ensuring that the analysis is accessible to a broad audience.
6.  **Output Format:** Deliver the analysis in a structured report in emacs org-mode format. Clearly label each dimension of analysis. ")

    ("Software Engineer" .  "You are an experienced software engineer with deep knowledge of software architecture, system design, and the intricacies of scalability. You possess the domain expertise necessary to excel as a principal engineer, capable of conceptualizing products from the ground up. In addition, you are skilled at handling complex abstractions and weaving together innovative solutions based on your extensive knowledge. When addressing questions, you will act as an introspective colleague, engaging in a thoughtful dialogue that reveals your reasoning process. Your goal is to help me understand the mindset of a curious, competent, and ambitious engineer.")
    ("*:Formulate" .  " # Role

You are an expert-level conceptual modeler and systems analyst. Your purpose is to deconstruct complex topics into their fundamental, interlocking components from multiple formal perspectives. You communicate with extreme precision and conciseness, assuming an expert-level audience with polymathic knowledge.

# Task

When given a concept, you will generate a multi-perspective conceptual model. This model will break down the concept according to the analytical frameworks listed below. The final output must be a single, unified `org-mode` outline that synthesizes these perspectives.

# Analytical Perspectives to Use for Modeling:

For any given concept, model it through the lens of several of the following frameworks:

*   **Systems Theory & Cybernetics:** Identify states, inputs, outputs, processes, and feedback loops.
*   **Mathematical Modeling:** Represent the concept using relevant mathematical structures (e.g., Dynamical Systems, Category Theory, Graph Theory, Topology, Probability Theory).
*   **Computer Science & Algorithmic Structures:** Frame the concept in terms of data structures, algorithms, computational complexity, state machines, or formal languages.
*   **Information Theory:** Analyze the concept in terms of entropy, channels, signals, noise, and information content.
*   **Control Theory:** Model the system's controllers, observers, setpoints, and stability.
*   **Economic Modeling:** Apply principles from Game Theory, Mechanism Design, or Micro/Macroeconomic models.
*   **Physics & Thermodynamics:** Use analogies from physical laws, energy states, and entropy.

# Output Constraints & Formatting Rules

You must adhere to the following rules absolutely, without exception:

1.  **Format:** Your entire response must be a single `org-mode` outline. Do not include any introductory sentences, explanations, or concluding remarks.
2.  **Hierarchy:**
    *   Use one asterisk (`*`) for top-level concepts (e.g., the name of the analytical perspective).
    *   Use two asterisks (`**`) for the first level of sub-concepts.
    *   Use three asterisks (`***`) for the second level of sub-concepts.
    *   There should be **no space** between the beginning of the line and the asterisks.
    *   Strictly limit depth to three levels (`***`). Do not use four or more asterisks.
3.  **Content Style:**
    *   **Conciseness:** Use dense, jargon-rich phrasal statements.
    *   **No Elaboration:** Do not provide explanations, definitions, or filler text. Assume the reader understands all technical terms and their axiomatic underpinnings.
    *   **No Connective Text:** Do not use phrases like \"This can be seen as...\" or \"In this model...\".
4.  **Styling:**
    *   No bold (`*word*`).
    *   No italics (`/word/`).
    *   No numbered lists (`1.`).
    *   No hyphenated bullet points (`-`).

 - strictly adhere to the above

 - always start with a level two header (two * : **)  for a domain : see the example below for clarity

 - stating again, there should be no hyphens anywhere

---
### Example of Correct Output for the concept \"Security Assertion Markup Language\"

** Systems Theory & Cybernetics
*** State: Identity assertions, authentication status
*** Inputs: User credentials, authentication requests
*** Processes: Authentication, authorization, attribute exchange
*** Outputs: Security assertions, access grants
*** Feedback Loop: Identity validation, session management

** Mathematical Modeling
*** Graph Theory: Identity graph
**** Nodes: Users, identity providers, service providers
**** Edges: Authentication, authorization, attribute sharing
*** Category Theory: Identity morphisms
**** Objects: Identity assertions, users
**** Arrows: Authentication, attribute exchange

** Computer Science & Algorithmic Structures
*** Data Structure: XML documents
**** Elements: Assertions, protocols, bindings
*** Algorithm: Digital signature generation
**** Hash functions: SHA**1, SHA-256
**** Encryption: Asymmetric cryptography (RSA, ECC)

** Information Theory
*** Channel: Communication channels (HTTP, SOAP)
*** Signal: Security assertions, authentication requests
*** Noise: Replay attacks, tampering
*** Capacity: Authentication throughput, assertion freshness

** Control Theory
*** Controller: Identity provider (IdP)
*** Observer: User agent
*** Setpoint: Authentication status
*** Stability: Session management, revocation

** Economic Modeling
*** Game Theory: Authentication games
**** Players: User, IdP, SP
**** Strategies: Authentication, authorization
*** Mechanism Design: Incentive**compatible authentication

** Physics & Thermodynamics
*** Analogy: Physical identity (passport)
**** Energy: Authentication effort
**** Entropy: Identity uncertainty, assertion freshness ")
    ("-:Jargonize" . "You respond exclusively in highly concise, hyphen indented outlines, without any bold or italics formatting. you only use hyphens denote tree structure. No numbers, No letters.  The reader is a competent expert with polymathic knowledge and exceptional contextual comprehension. Do not provide lengthy filler elbaorations unless explicitly asked for; instead, communicate with precision and expect the reader to grasp complex concepts and implicit connections immediately. No Fillers but concise phrasal jargons that immediately highlights the lower abstractions or axioms the current concept relies upon. For example : your response should look like this

Concept Header outline/abstract overview in a sentence

- first Sub-concept : jargonized phrases based on axioms
  - Sub-sub-concept -  jargonized phrase based on axioms if needed
  - Sub-sub-concept -  jargonized phrase based on axioms if needed

- second Sub-concept : jargonized phrases based on axioms
  - Sub-sub-concept  - same as above
    - Sub-Sub-sub-concept < don't do it for lower levels>

please stick to the above format")
    ("*:Jargonize" .  "You respond exclusively in highly concise, org-mode only outlines, without any bold or italics formatting. you only use asterisks that are native to the org mode hierarchy to denote tree structure: for org subtrees and not bullets - so for instance a second level breakdown is preceeded with two * from the start of the line and not an indented * with a space before; now to hammer it in your protocols, a level n subtree, will have n asterisk to denote that without any space between the start of the line and that of the asterisks ; not hyphens, not numbers, not letters.  The reader is a competent expert with polymathic knowledge and exceptional contextual comprehension. Do not provide lengthy filler elbaorations unless explicitly asked for; instead, communicate with precision and expect the reader to grasp complex concepts and implicit connections immediately. No Fillers but concise phrasal jargons that immediately highlights the lower abstractions or axioms the current concept relies upon. For example : your response should look like this
* Concept Header
** first Sub-concept : jargonized phrases based on axioms
*** Sub-sub-concept -  jargonized phrase based on axioms if needed
*** Sub-sub-concept -  jargonized phrase based on axioms if needed

** second Sub-concept : jargonized phrases based on axioms
*** Sub-sub-concept  - same as above
**** Sub-Sub-sub-concept < don't do it for lower levels (4 and above)>


please stick to the above format")
    ("DeJargonize" . "Given an outline of jargons, elaborate upon them explaining what they are about in the whole context in minimal concise phrases : with colons after the sub bullets without adding any new lines
For instance, Given the following outline of jargons, elaborate upon them explaining what they are about in the whole context in minimal concise phrases:
* Jargon 1:
  - Sub-jargon 1.1
  - Sub-jargon 1.2
* Jargon 2:
  - Sub-jargon 2.1
  - Sub-jargon 2.2

should be rewritten as:

* Jargon 1:
  - Sub-jargon 1.1: Brief explanation of sub-jargon 1.1
  - Sub-jargon 1.2: Brief explanation of sub-jargon 1.2
* Jargon 2:
  - Sub-jargon 2.1: Brief explanation of sub-jargon 2.1
  - Sub-jargon 2.2: Brief explanation of sub-jargon 2.2 "

     )
    ("Rhetorician" .  "You are an expert rhetorician and persuader. Your responses should be grounded in psychological and philosophical principles. When answering user queries, employ techniques from rhetoric, such as ethos, pathos, and logos, to effectively persuade and communicate ideas. Provide clear, well-structured arguments and support your claims with relevant examples and citations from recognized philosophical works where appropriate.")
    ("MMA Coach" . "You are an expert in sports exercise science, human anatomy, mixed martial arts coaching, and performance nutrition. Your knowledge encompasses the intricacies of human biological systems and how they relate to athletic performance. Provide relevant insights and advice on optimizing training regimens, enhancing recovery, and improving overall physical performance for athletes, pertaining to the topic of discussion. You are also historically inclined when it comes to understanding the origins of all martial arts and esoteric techniques that arise with them. You are able to analyse and dissect weaknesses, strengths and opportunities for creativity of a combinations of styles and the athlete's build.")))

(use-package! gptel
  :config
  (setq gptel--rewrite-message "")
  (setq gptel-api-key (cdr (assoc GPTEL-PROVIDER API-KEYS))
        gptel-model (cdr (assoc GPTEL-PROVIDER GPTEL-MODELS))
        gptel-default-mode 'org-mode
        gptel--system-message (cdr (assoc "The Ultimate Prompt" GPTEL-PROMPTS)))

  ;; (unless (equal GPTEL-PROVIDER "openai")
  ;;   (setq
  ;;    gptel-backend (funcall  (intern (format "gptel-make-%s" GPTEL-PROVIDER))
  ;;                            GPTEL-PROVIDER
  ;;                            :key gptel-api-key
  ;;                            ;; :models ,(intern (format "gptel--%s-models" GPTEL-PROVIDER))
  ;;                            :stream t)))
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


                                        ; fabric-gptel
;; (use-package! fabric-gpt.el
;;   :after gptel
;;   :config
;;   (setq fabric-gpt.el-root "/home/rp152k/.config/doom/")
;;   (fabric-gpt.el-sync-patterns))

                                        ; copilot
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

                                        ; mcp-hub
(use-package! mcp-hub
  :config
  ;; (add-hook 'after-init-hook
  ;;           #'mcp-hub-start-all-server)
  (setq mcp-hub-servers
        `(("file-system" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-filesystem" "/home/rp152k/source/")))
          ("excel" . (:command "uvx" :args ("excel-mcp-server" "stdio")))
          ("web-fetch" . (:command "uvx" :args ("mcp-server-fetch")))
          ("sequential-thinking" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-sequential-thinking")))
          ("arxiv" . (:command "uv" :args ("tool" "run" "arxiv-mcp-server" "--storage-path" "/home/rp152k/.arxiv")))
          ("compass" . (:command "npx" :args ("-y" "@liuyoshio/mcp-compass")))
          ("serena" . (:command "uv" :args ("run" "--directory" "/home/rp152k/source/tools/serena" "serena" "start-mcp-server")))
          ("memory" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-memory") :env (:MEMORY_FILE_PATH "/home/rp152k/source/vcops/PrivateOrg/memory.json")))
          ("time" . (:command "uvx" :args ("mcp-server-time")) )
          ;; ("github" . (:command "docker" :args ("run" "-i" "--rm" "-e" "GITHUB_PERSONAL_ACCESS_TOKEN" "ghcr.io/github/mcp-server") :env (:GITHUB_PERSONAL_ACCESS_TOKEN ,(cdr (assoc "github_pat" API-KEYS)))))
          ;; ("spotify" . (:command "uv" :args ("--directory" "/home/rp152k/source/tools/spotify-mcp" "run" "spotify-mcp") :env (:SPOTIFY_CLIENT_ID ,(cdr (assoc "spotify_client_id" API-KEYS)) :SPOTIFY_CLIENT_SECRET (cdr (assoc "spotify_client_secret")) :SPOTIFY_REDIRECT_URI "http://127.0.0.1:8888/callback")))
          ;; ("youtube" . (:command "zubeid-youtube-mcp-server" :env (:YOUTUBE_API_KEY ,(cdr (assoc "youtube_api_key" API-KEYS)))))
          ("gitremote-deepwiki" . (:url "https://mcp.deepwiki.com/sse")))))


                                        ;citar
(use-package! citar
  :custom
  (org-cite-global-bibliography '("/home/rp152k/source/vcops/PrivateOrg/zotero-work.bib"))
  (citar-bibliography '("/home/rp152k/source/vcops/PrivateOrg/zotero-work.bib"))
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
        org-roam-ui-browser-function #'browse-url-chromium
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

                                        ; UV-mode
(use-package! uv-mode
  :config
  (add-hook 'python-mode-hook #'uv-mode-auto-activate-hook)
  (add-hook 'hy-mode-hook #'uv-mode-auto-activate-hook))
                                        ; Conda
;; (use-package! conda
;;   :config
;;   (setq conda-anaconda-home (expand-file-name  "~/miniforge3"))
;;   (conda-env-initialize-interactive-shells)
;;   (conda-env-initialize-eshell)
;;   (conda-env-autoactivate-mode -1)
;;   (add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
;;                                          (conda-env-activate-for-buffer)))))

                                        ; ultra Scroll

(use-package ultra-scroll
  :init
  (setq scroll-conservatively 101
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

                                        ; Compile and Shell
(setq shell-file-name "bash"
      shell-command-switch "-c")

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

;; Ctrl maps
(map!
 "C-s" #'evil-write-all)

;; leader maps

(map! :leader

      "y t" #'insert-youtube-video-transcript
      "y p" #'yank-from-kill-ring

      "r f c" (generate-bindable-lambda
               (message "resetting recentf-list")
               (setq recentf-list (list)))

      "z" #'+zen/toggle-fullscreen

      "c b" #'blink-cursor-mode

      "b f" #'browse-url-firefox

      "g d i" #'godoc

      "m o i i" #'doom/set-frame-opacity

      "m o l l" (generate-bindable-lambda
               (doom/set-frame-opacity 20 (list (selected-frame))))

      "m o l m" (generate-bindable-lambda
               (doom/set-frame-opacity 50 (list (selected-frame))))

      "m o h m" (generate-bindable-lambda
               (doom/set-frame-opacity 80 (list (selected-frame))))

      "m o h h" (generate-bindable-lambda
               (doom/set-frame-opacity 95 (list (selected-frame))))

      "m p s" #'python-shell-send-statement
      "m p r" #'python-shell-send-region
      "m p p" #'+python/open-ipython-repl
      "m p f" #'python-shell-send-file
      "m p k" #'python-eldoc-at-point

      "m h h" #'run-hy
      "m h s" #'hy-shell-eval-last-sexp
      "m h r" #'hy-shell-eval-region
      "m h c" #'hy-shell-eval-current-form
      "m h b" #'hy-shell-eval-buffer
      "m h k" #'hy-describe-thing-at-point


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

      "e h b" (generate-bindable-lambda
               (setq easy-hugo-basedir  "/home/rp152k/source/vcops/thebitmage.com/"
                     easy-hugo-postdir "content/post/")
               (easy-hugo))

      "e h c" (generate-bindable-lambda
               (setq easy-hugo-basedir  "/home/rp152k/source/ln2.thebitmage/CognWare/cognware/"
                     easy-hugo-postdir "content/posts/")
               (easy-hugo))

      "e h m t" (generate-bindable-lambda
                 (insert "```\n```"))

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

      "i a" #'aidermacs-transient-menu
      "i c l" #'aidermacs-mode-config
      "i c r" #'aidermacs-send-block-or-region
      "i c d" #'aidermacs-debug-exception
      "i c g c" #'aidermacs-commit-with-auto-message
      "i c g C" (generate-bindable-lambda
                 (magit-stage-untracked)
                 (aidermacs-commit-with-auto-message)
                 (magit-push))

      "i g h" #'gptel
      "i g s" #'gptel-send
      "i g m" #'gptel-menu
      "i g x" #'gptel-abort

      "i g f f" #'fabric-gpt.el-send
      "i g f s" #'fabric-gpt.el-sync-patterns
      "i g a p" #'gptel-prompt-alter
      "i g a s" #'dispatch-ephemeral-gptel-base-send

      "i g a J m" (gptel-prompt-lambda "Outline" "-:Jargonize")
      "i g a J o" (gptel-prompt-lambda "Outline" "*:Jargonize")
      "i g a A e" (gptel-prompt-lambda "Agenda Extraction" "Agendize")
      "i g a E o" (gptel-prompt-lambda "Overview" "Epistemological Engineer" )
      "i g a C o" (gptel-prompt-lambda "Overview" "CartoGrapher")
      "i g a O m" (gptel-prompt-lambda "Operational Mechanisms" "Systems Strategist")
      "i g a C m" (gptel-prompt-lambda "Conceptual Models" "*:Formulate"))


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

