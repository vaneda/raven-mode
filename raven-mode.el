;;; lang/raven/raven.el -*- lexical-binding: t; -*-

(require 'polymode)
(require 'regexp-opt)

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

;;;###autoload (autoload 'vue-polymode "raven-mode")
(define-polymode vue-polymode
  :innermodes '(vue-template-innermode vue-script-innermode vue-css-innermode))

(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-polymode))

(provide 'raven-mode)
