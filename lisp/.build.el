(require 'cl-lib)

(defun find-local-dependency (pkg)
  "Get the package-file and directory where we expect PKG to live
See `emake-package-dev-locations-functions'."
  (let ((dir (expand-file-name (symbol-name pkg)
                               (emake--dir-parent emake-project-root))))

    (when (file-directory-p dir)
      ;; Some packages have a special directory structure where all lisp
      ;; is in a subdirectory.  Handle these cases here.
      (when-let ((entry (assq pkg '((magit "lisp" "lisp/magit-pkg.el")))))
        (pcase-let ((`(_ ,lisp-directory ,package-file) entry))
          (cons (expand-file-name package-file dir)
                (file-name-as-directory (expand-file-name lisp-directory dir))))))))

(push #'find-local-dependency emake-package-dev-locations-functions)

;;; Goal: determine all dependencies recursively
;;; Goal: provide the load-path for all packages already installed
