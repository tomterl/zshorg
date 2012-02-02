FILES="\"zshrc.org\""
DIR=$(pwd)
ORGINSTALL=${HOME}/.emacs.d/elpa/org-current/
ADDONS=${HOME}/.zsh.d/addons

tangle:
	emacs -Q --batch -L ${ORGINSTALL} \
		--eval "(progn \
			(require 'org) (require 'org-exp) (require 'ob) (require 'ob-tangle) \
			 (mapc (lambda (file) (find-file (expand-file-name file \"${DIR}\")) (org-babel-tangle) (kill-buffer)) '(${FILES})))" 

externals: 
	mkdir -p ${ADDONS}; \
	cd ${ADDONS}; \
	if [ ! -d zsh-history-substring-search ]; then git clone git://github.com/zsh-users/zsh-history-substring-search.git; fi; \
	if [ ! -d  zsh-syntax-highlighting ]; then git clone git://github.com/zsh-users/zsh-syntax-highlighting.git; fi

.PHONY: tangle externals
