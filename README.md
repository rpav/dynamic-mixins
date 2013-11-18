# dynamic-mixins

Dynamic-mixins is for simple, dynamic class combination:

```lisp
(in-package :dynamic-mixins)

(defclass a () ())
(defclass b () ())
(defclass c () ())

(make-instance (mix 'a 'b)) ;; => #<MIXIN-OBJECT (A B)>

(let ((a (make-instance 'a)))
  (ensure-mix a 'b 'c)      ;; => #<MIXIN-OBJECT (A B C)>
  (delete-from-mix a 'a)    ;; => #<MIXIN-OBJECT (B C)>
  (delete-from-mix a 'c))   ;; => #<B>
```

This allows objects to be mixed and updated without manually
defining many permutations.

## Dictionary

* `MIX &rest classes`: This produces a "mix
  list", which is generally only useful for passing to
  `MAKE-INSTANCE`.  Note: Order matters!  This determines class
  precedence.

* `ENSURE-MIX object &rest name-or-class`: Ensure that classes listed
  in `name-or-class` are part of `object`.  This will create a new
  class and `CHANGE-CLASS object` if necessary.  Note: Order matters!
  This determines class precedence.

* `DELETE-FROM-MIX object &rest name-or-class`: Remove classes listed
  in `name-or-class` from the object's class.  This will create a new
  class and `CHANGE-CLASS object` if necessary.  However, `object`
  must be a `MIXIN-OBJECT` created by `(MAKE-INSTANCE (MIX ...) ...)`
  or `ENSURE-MIX`.  Otherwise, nothing will be changed.

## Notes

Order matters; you are defining a new class which has the specified
classes as direct superclasses.  `ENSURE-MIX` appends classes.

It is possible to produce errors that may be difficult to recover
from, if you violate CLOS precedence rules.  This is because CLOS (at
least on SBCL and CCL, tested) keeps a reference to offending
anonymous classes, but provides no way for code to get a reference or
handle this.
