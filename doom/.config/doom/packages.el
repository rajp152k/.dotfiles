;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

(package! tldr)

(package! easy-hugo
  :recipe (:host github :repo "/masasam/emacs-easy-hugo"))

(package! gptel)

(package! org-roam-ui)

(package! exec-path-from-shell)

(package! nov
  :recipe (:host github :repo "/wasamasa/nov.el"))

(package! ultra-scroll
  :recipe (:host github :repo "/jdtsmith/ultra-scroll"))

(package! crosshairs
  :recipe (:host github :repo "/rajp152k/crosshairs"))

(package! replace-colorthemes
  :recipe (:host github :repo "/rajp152k/replace-colorthemes"))

(package! fabric-gpt.el
  :recipe (:host github :repo "/rajp152k/fabric-gpt.el"))

(package! ob-mermaid
  :recipe (:host github :repo "/arnm/ob-mermaid"))

(package! nth-roam
  :recipe (:host github :repo "/rajp152k/nth-roam"))

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

(package! mcp-hub
  :recipe (:host github :repo "lizqwerscott/mcp.el"))

;; (package! spacious-padding
;;   :recipe (:host github :repo "protesilaos/spacious-padding"))

(package! aidermacs
  :recipe (:host github :repo "MatthewZMD/aidermacs"))

(package! emigo
  :recipe (:host github :repo "rajp152k/emigo" :files (:defaults "*.py" "*.el")))

(package! md-babel
  :recipe  (:host github :repo "md-babel/md-babel.el"))

(package! uv-mode
  :recipe  (:host github :repo "z80dev/uv-mode"))


(package! kubernetes)
(package! kubernetes-evil)
