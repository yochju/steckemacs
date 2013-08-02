# in .bashrc use:
# export STECKEMACS_REMOTE=<remote location>

emacs := emacs --no-site-file --batch
steckemacs_remote := $(STECKEMACS_REMOTE)
dir := $(dir $(lastword $(MAKEFILE_LIST)))

all: html deploy

deploy:
	@if [ -n "$(steckemacs_remote)" ]; then \
		echo Deploying to $(steckemacs_remote) ... ; \
		scp $(dir)steckemacs.html $(steckemacs_remote); \
	else \
		return 1; \
	fi
	@echo

html:
	@echo Starting Emacs...
	@$(emacs) --eval \
	"(progn \
	(package-initialize) \
	(require 'org) \
	(setq org-confirm-babel-evaluate nil) \
	(find-file \"steckemacs.org\") \
	(org-export-to-file 'html \"steckemacs.html\") \
	)"
	@echo
