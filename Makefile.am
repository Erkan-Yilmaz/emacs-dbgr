SUBDIRS = dbgr

lispdir = @lispdir@
lisp_files := $(wildcard dbgr.el)
lisp_LISP = $(lisp_files)

include common.mk

EXTRA_DIST=common.mk README.textile

if MAINTAINER_MODE

CL = ChangeLog
ChangeLog:
	git log --pretty --numstat --summary | $(GIT2CL) > $@

ACLOCAL_AMFLAGS=-I .

endif

test: check

check-short:
	$(MAKE) check 2>&1  | ruby make-check-filter.rb





