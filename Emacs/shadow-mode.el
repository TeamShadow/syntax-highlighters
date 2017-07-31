;;; shadow-mode.el --- sample major mode for editing Shadow. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2017, Team Shadow

;; Author: Barry Wittman
;; Version: 0.7.5
;; Created: July 31, 2017
;; Keywords: languages
;; Homepage: http://www.shadow-language.org

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the Apache License 2.0.

;;; Commentary:

;; Sample major mode for editing Shadow source code.


;;; Code:

;; define several category of keywords
(setq shadow-keywords '("abstract" "and" "assert" "break" "case" "cast" "catch" "check" "class" "constant" "continue" "copy" "create" "default" "destroy" "do" "else" "enum" "exception" "extern" "finally" "for" "foreach" "freeze" "get" "if" "immutable" "import" "in" "interface" "is" "locked" "native" "nullable" "or" "private" "protected" "public" "readonly" "recover" "return" "send" "set" "singleton" "skip" "spawn" "super" "switch" "this" "throw" "try" "weak" "while" "xor") )
(setq shadow-types '("boolean" "byte" "code" "double" "float" "int" "long" "short" "ubyte" "uint" "ulong" "ushort" "var"))
(setq shadow-constants '("false" "null" "true"))

;; generate regex string for each category of keywords
(setq shadow-keywords-regexp (regexp-opt shadow-keywords 'words))
(setq shadow-type-regexp (regexp-opt shadow-types 'words))
(setq shadow-constant-regexp (regexp-opt shadow-constants 'words))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq shadow-font-lock-keywords
      `(
		(,shadow-keywords-regexp . font-lock-keyword-face)
        (,shadow-type-regexp . font-lock-type-face)
        (,shadow-constant-regexp . font-lock-constant-face)        
        ;; note: order above matters, because once colored, that part won't change.
        ;; in general, longer words first
        ))

;;;###autoload
(define-derived-mode shadow-mode c-mode "shadow mode"
  "Major mode for editing Shadow"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((shadow-font-lock-keywords))))

;; clear memory. no longer needed
(setq shadow-keywords nil)
(setq shadow-types nil)
(setq shadow-constants nil)

;; clear memory. no longer needed
(setq shadow-keywords-regexp nil)
(setq shadow-types-regexp nil)
(setq shadow-constants-regexp nil)

;; add the mode to the `features' list
(provide 'shadow-mode)

;; setup files ending in “.shadow” to open in shadow-mode
(add-to-list 'auto-mode-alist '("\\.shadow\\'" . shadow-mode))

;;; shadow-mode.el ends here