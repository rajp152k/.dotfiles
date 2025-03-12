;;; ../../.dotfiles/doom/.config/doom/utils.el -*- lexical-binding: t; -*-

(defmacro ascdr (key hash)
  `(cdr (assoc ,key ,hash)))
