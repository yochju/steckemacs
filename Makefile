EMACS=emacs -q --no-site-file -batch

all:
	$(EMACS) --eval \
	"(progn \
	(package-initialize) \
	(require 'org) \
	(setq org-confirm-babel-evaluate nil) \
	(org-babel-tangle-file \"steckemacs.org\") \
	)"
