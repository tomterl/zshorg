FILES="\"zshrc.org\""
DIR=$(pwd)
ORGINSTALL=${HOME}/.emacs.d/elpa/org-current/

tangle:
	emacs -Q --batch -L ${ORGINSTALL} \
		--eval "(progn \
			(require 'org) (require 'org-exp) (require 'ob) (require 'ob-tangle) \
			 (mapc (lambda (file) (find-file (expand-file-name file \"${DIR}\")) (org-babel-tangle) (kill-buffer)) '(${FILES})))" 
