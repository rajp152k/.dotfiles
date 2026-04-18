;;; state.el -*- lexical-binding: t; -*-
;; Central state management for Doom Emacs configuration
;; All system/user-specific paths defined here for portability

;; USER IDENTIFICATION

;; Allow override via environment variables for multi-user setups
(defconst STATE-USER (or (getenv "DOOM_USER") "username"))
(defconst STATE-USER-EMAIL (or (getenv "DOOM_EMAIL") "user@example.com"))
(defconst STATE-USER-FULL-NAME (or (getenv "DOOM_FULLNAME") "fullusername"))
(defconst STATE-HOME (or (getenv "DOOM_HOME") (getenv "HOME")))

;; OS DETECTION

(defconst STATE-OS-TYPE (or (getenv "OS_TYPE") 'linux))
(defconst STATE-IS-MACOS (eq STATE-OS-TYPE 'macos))
(defconst STATE-IS-LINUX (eq STATE-OS-TYPE 'linux))

;; DIRECTORY PATHS

;; Base directories
(defconst STATE-SOURCE-DIR (expand-file-name "source" STATE-HOME))
(defconst STATE-DOTFILES (expand-file-name ".dotfiles" STATE-HOME))
(defconst STATE-DOOM-DIR (expand-file-name ".config/doom" STATE-HOME))
(defconst STATE-TOOLS-DIR (expand-file-name "tools" STATE-SOURCE-DIR))

;; Secrets file
(defconst STATE-SECRETS-FILE (expand-file-name "secrets.el" STATE-DOOM-DIR))

;; Org directories
(defconst STATE-ORG-DIR (expand-file-name "vcops/org" STATE-SOURCE-DIR))
(defconst STATE-ORG-GTD-HQ (expand-file-name "GTD/GTD_HQ.org" STATE-ORG-DIR))
(defconst STATE-ORG-ROAM-DIR (expand-file-name "PrivateOrg/cartograph" STATE-ORG-DIR))
(defconst STATE-ORG-ZOTERO-BIB (expand-file-name "PrivateOrg/zotero-work.bib" STATE-ORG-DIR))

;; Project directories
(defconst STATE-BIT-MAGE-DIR (expand-file-name "vcops/bit-mage" STATE-SOURCE-DIR))
(defconst STATE-COGNWARE-DIR (expand-file-name "vcops/cognware" STATE-SOURCE-DIR))

;; ============================================================================
;; EXTERNAL TOOLS (System-Specific)
;; ============================================================================

;; Mermaid CLI path (for org babel)
(defconst STATE-MERMAID-CLI
  (cond
   (STATE-IS-MACOS "/usr/local/bin/mmdc")
   (STATE-IS-LINUX "/usr/bin/mmdc")
   (t "mmdc")))  ; Fallback to PATH lookup

;; Clojure LSP server
(defconst STATE-CLOJURE-LSP
  (cond
   (STATE-IS-MACOS "/opt/homebrew/bin/clojure-lsp")
   (STATE-IS-LINUX "/usr/bin/clojure-lsp")
   (t "clojure-lsp")))

;; Java LSP server (commented in original)
;; (defconst STATE-JDTLS
;;   (cond
;;      (STATE-IS-MACOS "/opt/homebrew/bin/jdtls")
;;      (STATE-IS-LINUX "/usr/bin/jdtls")
;;      (t "jdtls")))

;; Whisper.el installation path
(defconst STATE-WHISPER-PATH (expand-file-name "whisper.el" STATE-TOOLS-DIR))

;; ============================================================================
;; THEME PATHS
;; ============================================================================

(defconst STATE-CUSTOM-THEMES-PATH
  (expand-file-name ".config/emacs/.local/straight/repos/replace-colorthemes" STATE-HOME))
(defconst STATE-BIT-MAGE-THEME
  (expand-file-name ".load/bit-mage-theme.el" STATE-HOME))

;; ============================================================================
;; MCP/EXTERNAL SERVICES
;; ============================================================================

;; ArXiv storage
(defconst STATE-ARXIV-DIR (expand-file-name ".arxiv" STATE-HOME))

;; Source root for file-system MCP
(defconst STATE-MCP-FILESYSTEM-PATH STATE-SOURCE-DIR)

;; ============================================================================
;; PROVIDE
;; ============================================================================

(provide 'state)
