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

;; Please set your themes directory to 'custom-theme-load-path
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "/home/rp152k/.config/emacs/.local/straight/repos/replace-colorthemes"))

;; (load-theme 'modus-vivendi t)
(load-theme 'lawrence t)

(setq pdf-view-midnight-colors (cons "#00ff00" "#000000")
      pdf-view-midnight-invert nil)


(doom/set-frame-opacity 0.8)

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
  "insert youtube video transcript in the current buffer"
  (interactive)
  (let ((url (read-string "video url:")))
    (insert (shell-command-to-string (format "fabric -y %s" url)))))

(setq shell-command-prompt-show-cwd t)
                                        ; Babel
(use-package! org
  :config
  (setq ob-mermaid-cli-path "/home/rp152k/miniforge3/bin/mmdc")
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
        '(("n" "Next Action" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Next Action")
           "* TODO [%] %?\n  %i\n  %a")
          ("o" "Open Source" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Open Source")
           "*  [%] [OS] %?\n  %i\n  %a")
          ("c" "Content" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Content")
           "*  [%] [CNTNT] %?\n  %i\n  %a")
          ("m" "Meet Log" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Meet Logs")
           "* @ %? w/")
          ("e" "Event" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Events")
           "* %?\nSCHEDULED: %T\n  %i")
          ("i" "IN" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "INQ")
           "*  [%] [INQ] %?\nEntered on %U\n  %i\n  %a")
          ("r" "Roam" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Roam")
           "*  [%] [ROAM] %?\n  %i\n  %a")
          ("k" "ICBM" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "ICBM")
           "*  [%] [ICBM] %?\nEntered on %U\n  %i\n  %a")
          ("a" "Agentify" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Agentify")
           "*  [%] [AGNTFY] %?\nEntered on %U\n  %i\n  %a")
          ("t" "Thunk" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Thunk")
           "*  [%] [THUNK] %?\nEntered on %U\n  %i\n  %a")
          ("f" "Fire" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Fire")
           "* TODO [%] [FIRE] %?\nEntered on %U\n  %i\n  %a")
          ("b" "Business" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "Business")
           "* TODO [%] [BSNS] %?\nEntered on %U\n  %i\n  %a")
          ("u" "UTIL" entry (file+headline "/home/rp152k/source/vcops/org/GTD/GTD_HQ.org" "UTIL")
           "*  [%] [UTIL] %?\n %i\n %a"))))

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
  (nth-roam-default-vault-register "thebitmage" "/home/rp152k/source/vcops/org/roam/Content")
  (nth-roam-register-vault "study" "/home/rp152k/source/vcops/PrivateOrg/study")
  (nth-roam-register-vault "cognware" "/home/rp152k/source/ln2.thebitmage/CognWare/roam")
  (nth-roam-init "thebitmage"))

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


                                        ; aider
(use-package! aidermacs
  :config
  (setenv "OPENAI_API_KEY" (cdr (assoc "openai" API-KEYS)))
  (setenv "OPENROUTER_API_KEY" (cdr (assoc "openrouter" API-KEYS)))
  (add-to-list 'aidermacs-extra-args "--no-show-model-warnings" )
  (add-to-list 'aidermacs-extra-args "--subtree-only")
  (setq aidermacs-backend 'vterm)
  (setq aidermacs-use-architect-mode t)
  (setq aidermacs-show-diff-after-change nil)
  (setq aidermacs-architect-model "o4-mini")
  (setq aidermacs-default-model "gpt-4.1-mini"))


(defun aidermacs-mode-config ()
  (interactive)
  (cl-flet ((alter-models (flash think)
              (setq aidermacs-architect-model think
                    aidermacs-default-model flash)
              (message (format "Aider flash : %s | Aider think : %s"
                               flash
                               think))))
    (let ((mode (completing-read "Aider Mode: " '("work"
                                                  "openai"
                                                  "deepseek"
                                                  "gemini"
                                                  "llama"
                                                  "claude"))))
      (cl-case (intern mode)
        (work (alter-models "openai/gpt-4.1-mini" "openai/o4-mini"))
        (deepseek (alter-models "openrouter/deepseek/deepseek-chat" "openrouter/deepseek/deepseek-r1" ))
        (claude (alter-models "openrouter/anthropic/claude-3-7-haiku" "openrouter/anthropic/claude-3.7-sonnet"))
        (gemini (alter-models "openrouter/google/gemini-2.5-flash-preview" "openrouter/google/gemini-2.5-flash-preview:thinking" ))
        (llama (alter-models "openrouter/meta-llama/llama-4-scout" "openrouter/meta-llama/llama-4-maverick"))
        (openai (alter-models "openrouter/openai/gpt-4.1-mini" "openrouter/openai/o4-mini"))))))

(defvar GPTEL-PROVIDER "openrouter"
  "Provider for GPTel.")

(defvar GPTEL-MODELS
  (list
   (cons "openai" 'gpt-4.1-mini)
   (cons "gemini" 'gemini-2.5-flash)
   (cons "openrouter" 'openai/gpt-4.1-mini))
  "List of defualt init models for GPTel.")

(defvar GPTEL-PROMPTS
  '(("Life Hacker" . " You are a life hacker with a wealth of knowledge on productivity, organization, and self-improvement techniques. Provide actionable tips and insights for optimizing daily routines, managing time effectively, and enhancing overall well-being. Aim for responses that are specific, practical, and tailored to individual circumstances. If a user provides a particular challenge or goal, focus your advice on that situation, offering multiple strategies when possible. ")
    ("Raw" .  "be precise, exhaustive, unbiased, analytical and critical")
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
    ("Jargonize" .  "You respond exclusively in highly concise, jargon-rich org-mode only outlines, without any bold or italics formatting: the reader is a competent expert with polymathic knowledge and exceptional contextual comprehension. Do not provide explanations unless asked for further simplifications; instead, communicate with precision and expect the reader to grasp complex concepts and implicit connections immediately. Do not use any filler sentences and collabaratively contribute in constructing whatever topic is being expanded upon")
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
    ("MMA Coach" . "You are an expert in sports exercise science, human anatomy, mixed martial arts coaching, and performance nutrition. Your knowledge encompasses the intricacies of human biological systems and how they relate to athletic performance. Provide relevant insights and advice on optimizing training regimens, enhancing recovery, and improving overall physical performance for athletes, pertaining to the topic of discussion. You are also historically inclined when it comes to understanding the origins of all martial arts and esoteric techniques that arise with them. You are able to analyse and dissect weaknesses, strengths and opportunities for creativity of a combinations of styles and the athlete's build."))
  "List of prompts for GPTel.")

(use-package! gptel
  :config
  (setq gptel--rewrite-message "")
  (setq gptel-api-key (cdr (assoc GPTEL-PROVIDER API-KEYS))
        gptel-model (cdr (assoc GPTEL-PROVIDER GPTEL-MODELS))
        gptel-default-mode 'markdown-mode
        gptel--system-message (cdr (assoc "Raw" GPTEL-PROMPTS)))

  ;; (unless (equal GPTEL-PROVIDER "openai")
  ;;   (setq
  ;;    gptel-backend (funcall  (intern (format "gptel-make-%s" GPTEL-PROVIDER))
  ;;                            GPTEL-PROVIDER
  ;;                            :key gptel-api-key
  ;;                            ;; :models ,(intern (format "gptel--%s-models" GPTEL-PROVIDER))
  ;;                            :stream t)))
  (setq gptel-model   'meta-llama/llama-4-maverick
        gptel-backend
        (gptel-make-openai "OpenRouter"
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key (cdr (assoc "openrouter" API-KEYS))
          :models '(openai/gpt-4.1
                    openai/gpt-4.1-nano
                    openai/gpt-4.1-mini
                    openai/o4-mini-high
                    openai/o4-mini

                    meta-llama/llama-4-maverick:free
                    meta-llama/llama-4-maverick
                    meta-llama/llama-4-scout:free
                    meta-llama/llama-4-scout

                    deepseek/deepseek-chat
                    deepseek/deepseek-chat-v3-0324
                    deepseek/deepseek-r1
                    deepseek/deepseek-r1-distill-llama-70b

                    mistralai/mixtral-8x7b-instruct
                    mistralai/codestral-2501
                    mistralai/codestral-mamba
                    mistralai/ministral-8b
                    mistralai/mistral-small-3.1-24b-instruct
                    mistralai/mistral-saba

                    anthropic/claude-3.7-sonnet:thinking
                    anthropic/claude-3.7-sonnet
                    anthropic/claude-3.5-haiku

                    google/gemini-2.5-flash-preview:thinking
                    google/gemini-2.5-flash-preview
                    google/gemini-2.5-pro-preview-03-25

                    qwen/qwen3-30b-a3b
                    qwen/qwen3-8b:free
                    qwen/qwen3-14b
                    qwen/qwen3-32b
                    qwen/qwen3-235b-a22b

                    x-ai/grok-3-mini-beta
                    x-ai/grok-3-beta))))



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

                                        ; fabric-gptel
(use-package! fabric-gpt.el
  :after gptel
  :config
  (setq fabric-gpt.el-root "/home/rp152k/.config/doom/")
  (fabric-gpt.el-sync-patterns))

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
        '(("file-system" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-filesystem" "/home/rp152k/source/")))
          ("fetch" . (:command "uvx" :args ("mcp-server-fetch"))))))

(defun gptel-mcp-register-tool ()
  (interactive)
  (let ((tools (mcp-hub-get-all-tool :asyncp t :categoryp t)))
    (mapcar #'(lambda (tool)
                (apply #'gptel-make-tool
                       tool))
            tools)))

(defun gptel-mcp-use-tool ()
  (interactive)
  (let ((tools (mcp-hub-get-all-tool :asyncp t :categoryp t)))
    (mapcar #'(lambda (tool)
                (let ((path (list (plist-get tool :category)
                                  (plist-get tool :name))))
                  (push (gptel-get-tool path)
                        gptel-tools)))
            tools)))

(defun gptel-mcp-close-use-tool ()
  (interactive)
  (let ((tools (mcp-hub-get-all-tool :asyncp t :categoryp t)))
    (mapcar #'(lambda (tool)
                (let ((path (list (plist-get tool :category)
                                  (plist-get tool :name))))
                  (setq gptel-tools
                        (cl-remove-if #'(lambda (tool)
                                          (equal path
                                                 (list (gptel-tool-category tool)
                                                       (gptel-tool-name tool))))
                                      gptel-tools))))
            tools)))

                                        ;citar
(use-package! citar
  :custom
  (org-cite-global-bibliography '("/home/rp152k/source/vcops/org/roam/Content/bib/references.bib"))
  (citar-bibliography '("/home/rp152k/source/vcops/org/roam/Content/bib/references.bib"))
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

                                        ; Ultra Scroll

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

      "y t" #'insert-youtube-video-transcript

      "r f c" (lambda ()
                (interactive)
                (message "resetting recentf-list")
                (setq recentf-list (list)))

      "z" #'+zen/toggle-fullscreen

      "c b" #'blink-cursor-mode

      "b f" #'browse-url-firefox

      "g d i" #'godoc

      "m o i" #'doom/set-frame-opacity

      "m p s" #'python-shell-send-statement
      "m p r" #'python-shell-send-region
      "m p p" #'+python/open-ipython-repl
      "m p f" #'python-shell-send-file

      "m h h" #'run-hy
      "m h s" #'hy-shell-eval-last-sexp
      "m h r" #'hy-shell-eval-region
      "m h c" #'hy-shell-eval-current-form
      "m h b" #'hy-shell-eval-buffer
      "m h k" #'hy-describe-thing-at-point

      "m t t"  #'modus-themes-toggle

      "m s t" (lambda ()
                "dispatch SOS timer alarm via shell command for read seconds"
                (interactive)
                (let ((seconds (read-number "SOS in seconds: ")))
                  (call-process-shell-command (format "timer %s" seconds) nil nil nil)))

      "m s f p" (lambda ()
                  "open a particular localhost port in firefox"
                  (interactive)
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
      "l t" #'time-stamp

      "o g w" #'gtd-workspace
      "o g a" #'gtd-workspace-archive

      "e h " nil

      "e h b" (lambda ()
                (interactive)
                (setq easy-hugo-basedir  "/home/rp152k/source/vcops/thebitmage.com/"
                      easy-hugo-postdir "content/post/")
                (easy-hugo))

      "e h c" (lambda ()
                (interactive)
                (setq easy-hugo-basedir  "/home/rp152k/source/ln2.thebitmage/CognWare/cognware/"
                      easy-hugo-postdir "content/posts/")
                (easy-hugo))

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
      "n r u z" (lambda ()
                  (interactive)
                  (org-roam-ui-node-zoom (org-roam-id-at-point)
                                         100
                                         20))
      "n r u f f" #'org-roam-ui-follow-mode
      "n r u l l" (lambda ()
                    (interactive)
                    (org-roam-ui-node-local (org-roam-id-at-point)
                                            100
                                            20))

      "n r u l c" #'org-roam-ui-change-local-graph
      "n r u l a" #'org-roam-ui-add-to-local-graph
      "n r u l d" #'org-roam-ui-remove-from-local-graph


      "n r u l c" #'org-roam-ui-change-local-graph
      "n r u l a" #'org-roam-ui-add-to-local-graph
      "n r u l d" #'org-roam-ui-remove-from-local-graph


      "m d h" #'shortdoc


      "m c t t" #'copilot-mode
      "m c p" #'copilot-panel-complete

      "i a" #'aidermacs-transient-menu
      "i c" #'aidermacs-mode-config

      "i g h" #'gptel
      "i g s" #'gptel-send
      "i g m" #'gptel-menu
      "i g x" #'gptel-abort

      "i g f f" #'fabric-gpt.el-send
      "i g f s" #'fabric-gpt.el-sync-patterns
      "i g a p" #'gptel-prompt-alter
      "i g a s" #'dispatch-ephemeral-gptel-base-send)
