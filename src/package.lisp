(defpackage :dynamic-mixins
  (:use #:closer-common-lisp #:alexandria)
  (:export #:mixin-class #:mixin-object
           #:ensure-mix #:delete-from-mix #:mix))
