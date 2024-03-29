;;; raven-mode.el --- Vue File Editing Mode Based on Polymode -*- lexical-binding: t; -*-

;; Name: raven-mode
;; Author: Wilson Waddell <wilsonwaddell1@gmail.com>
;; Keywords: languages, vue, javascript
;; Package-Requires: ((polymode "0.2") (regexp-opt "*"))
;; License: MIT

;;; Commentary:

;;

;;; Code:

(require 'polymode)
(require 'regexp-opt)

;;;###autoload
(defun raven/poly-fontlock (old-buff new-buff)
  "Call fontify on the buffer polymode is switching to.
Some modes (js2-mode) don't properly fontify.

   OLD-BUFF buffer polymode is leaving
   NEW-BUFF buffer polymode is entering"
  (font-lock-fontify-buffer new-buff))

(defvar vue-template-start-regexp
  (regexp-opt '("<template lang=\"pug\"")))

(defvar vue-template-end-regexp
  (regexp-opt '("</template>")))

(defvar vue-script-start-regexp
  (regexp-opt '("<script>")))

(defvar vue-script-end-regexp
  (regexp-opt '("</script>")))

(defvar vue-css-start-regexp
  (regexp-opt '("<style lang=\"scss\">" "<style lang=\"scss\" scoped>")))

(defvar vue-css-end-regexp
  (regexp-opt '("</style>")))

(define-innermode vue-template-innermode
  ;; Inner mode for vue templates in .vue files
  :mode 'pug-mode
  :head-matcher vue-template-start-regexp
  :tail-matcher vue-template-end-regexp)

(define-innermode vue-script-innermode
  ;; Inner mode for js in .vue files
  :mode 'js2-mode
  :head-matcher vue-script-start-regexp
  :tail-matcher vue-script-end-regexp)

(define-innermode vue-css-innermode
  ;; Inner mode for scss in .vue files
  :mode 'sass-mode
  :head-matcher vue-css-start-regexp
  :tail-matcher vue-css-end-regexp)

(define-hostmode vue-hostmode
  :mode 'prog-mode)

;;;###autoload (autoload 'raven-mode "raven-mode")
(define-polymode raven-mode
  :hostmode 'vue-hostmode
  :innermodes '(vue-template-innermode vue-script-innermode vue-css-innermode)
  :switch-buffer-functions '(raven/poly-fontlock))


(provide 'raven-mode)

;;; raven-mode.el ends here
