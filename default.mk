PKG = forge

ELS  += $(PKG)-db.el
ELS  += $(PKG)-core.el
ELS  += $(PKG).el
ELS  += $(PKG)-repo.el
ELS  += $(PKG)-post.el
ELS  += $(PKG)-topic.el
ELS  += $(PKG)-issue.el
ELS  += $(PKG)-pullreq.el
ELS  += $(PKG)-notify.el
ELS  += $(PKG)-revnote.el
ELS  += $(PKG)-github.el
ELS  += $(PKG)-gitlab.el
ELS  += $(PKG)-gitea.el
ELS  += $(PKG)-gogs.el
ELS  += $(PKG)-bitbucket.el
ELS  += $(PKG)-semi.el
ELS  += $(PKG)-commands.el
ELS  += $(PKG)-list.el
ELCS  = $(ELS:.el=.elc)

EMAKE_WORKDIR  ?= .emake
EMAKE_LOGLEVEL ?= INFO

EMACS      ?= emacs
EMACS_ARGS ?=

ifndef ORG_LOAD_PATH
ORG_LOAD_PATH  = -L ../../dash
ORG_LOAD_PATH += -L ../../org/lisp
ORG_LOAD_PATH += -L ../../org/contrib/lisp
ORG_LOAD_PATH += -L ../../ox-texinfo+
endif

INSTALL_INFO     ?= $(shell command -v ginstall-info || printf install-info)
MAKEINFO         ?= makeinfo
MANUAL_HTML_ARGS ?= --css-ref /assets/page.css
