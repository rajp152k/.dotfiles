;;; ../../.dotfiles/doom/.config/doom/higher-roam.el -*- lexical-binding: t; -*-

;; higher order functionalities for org-roam

(require 'org)
(require 'org-roam)
(require 'org-roam-ui)

;; given a text subnode of a higher order node, generate a new node with predefined set of tags
;; design breakdown
;; fetch tags from context

