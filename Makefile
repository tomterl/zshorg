FILES:="\"zshrc.org\""
DIR:=$(shell pwd)
ORGINSTALL:=${HOME}/.emacs.src.d/org-mode/lisp/
ADDONS:=${HOME}/.zsh.d/addons
EXTERNALS:=zsh-history-substring-search zsh-syntax-highlighting
SHELL:=zsh

tangle:
	@emacs -Q --batch -L ${ORGINSTALL} \
		--eval "(progn \
			(require 'org) (require 'ob) (require 'ob-tangle) \
			 (mapc (lambda (file) (find-file (expand-file-name file \"$(DIR)\")) (org-babel-tangle) (kill-buffer)) '($(FILES))))" 

externals: 
	@mkdir -p $(ADDONS); \
		pushd $(ADDONS); \
		for addon in $(EXTERNALS); do if [ ! -d "$${addon}" ]; then echo "Installing $${addon}"; git clone git://github.com/zsh-users/$${addon}; fi; done; \
		popd

update-externals:
	@pushd $(ADDONS); \
		for addon in $(EXTERNALS); do if [ -d "$${addon}" ]; then echo "Updating $${addon}"; pushd $${addon}; git pull; popd; fi; done; \
	popd

.PHONY: tangle externals update-externals
