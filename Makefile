# in .bashrc use:
# export STECKEMACS_REMOTE=<remote location>

emacs := emacs -Q -nw --kill
steckemacs_remote := $(STECKEMACS_REMOTE)
dir := $(dir $(lastword $(MAKEFILE_LIST)))

all: push html deploy

deploy:
	@if [ -n "$(steckemacs_remote)" ]; then \
		echo Deploying to $(steckemacs_remote) ... ; \
		scp $(dir)steckemacs.html $(steckemacs_remote); \
	else \
		echo STECKEMACS_REMOTE not set!; \
		exit 1; \
	fi

html:
	@echo Creating html...
	@$(emacs) --eval \
	"(progn \
	(package-initialize) \
	(load-theme 'grandshell t) \
	(require 'org) \
	(setq org-confirm-babel-evaluate nil) \
	(find-file \"steckemacs.org\") \
	(org-export-to-file 'html \"steckemacs.html\") \
	)"
	@echo Done.

push: commited
	@git push origin master

commited:
	@untracked=`git ls-files --other --directory --exclude-standard`; \
	echo $$untracked; \
	if [ -n "$$untracked" ]; then exit 1; fi
	@git diff --cached --exit-code
	@git diff --exit-code

