-include ../config.mk
include ../default.mk

EMAKE_SHA1 := 2dce38f5cdf9b7823fc16c5d0be2be615f8ff9f9

EMAKE_ENV += PACKAGE_FILE="$(PKG)-pkg.el"
EMAKE_ENV += PACKAGE_LISP="$(ELS)"
EMAKE_ENV += PACKAGE_ARCHIVES="gnu melpa"
EMAKE_ENV += EMAKE_WORKDIR="$(EMAKE_WORKDIR)"
EMAKE_ENV += EMAKE_LOGLEVEL="$(EMAKE_LOGLEVEL)"

# Then, make it easy to invoke Emacs with EMake loaded.
EMAKE = $(EMAKE_ENV) $(EMACS) --quick --batch --load '$(EMAKE_WORKDIR)/emake.el' \
	--eval "(setq enable-dir-local-variables nil)" \
	-L . \
	-l .build.el \
	$(EMACS_ARGS) \
	--eval "(emake (pop argv))"

CURL := curl --fail --silent --show-error --insecure --location --retry 9 --retry-delay 9

$(EMAKE_WORKDIR)/elpa: $(EMAKE_WORKDIR)/emake.el
	$(EMAKE) install

$(EMAKE_WORKDIR):
	mkdir -p $(EMAKE_WORKDIR)

$(EMAKE_WORKDIR)/emake.el: $(EMAKE_WORKDIR)
	$(CURL) 'https://raw.githubusercontent.com/vermiculus/emake.el/$(EMAKE_SHA1)/emake.el' \
	  --output '$(EMAKE_WORKDIR)/emake.el'

lisp: $(EMAKE_WORKDIR)/elpa loaddefs $(ELS)
	$(EMAKE) compile

loaddefs: $(PKG)-autoloads.el

CLEAN  = $(ELCS) $(PKG)-autoloads.el $(EMAKE_WORKDIR)

clean:
	@printf "Cleaning...\n"
	@rm -rf $(CLEAN)

define LOADDEFS_TMPL
;;; $(PKG)-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name \
(or (file-name-directory #$$) (car load-path))))

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; $(PKG)-autoloads.el ends here
endef
export LOADDEFS_TMPL
#'

$(PKG)-autoloads.el: $(ELS)
	@printf "Generating $@\n"
	@printf "%s" "$$LOADDEFS_TMPL" > $@
	@$(EMACS) -Q --batch --eval "(progn\
	(setq make-backup-files nil)\
	(setq vc-handled-backends nil)\
	(setq default-directory (file-truename default-directory))\
	(setq generated-autoload-file (expand-file-name \"$@\"))\
	(setq find-file-visit-truename t)\
	(update-directory-autoloads default-directory))"
