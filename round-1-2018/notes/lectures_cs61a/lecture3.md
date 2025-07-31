## Lecture 3

* FuNcTiOnS oF fUnCtIoNs
  -> passing functions as arguments to procedures
  -> helps generalise functions
  
  -> i.e. the sum function...
(define (sum fn a b)
  (if (> a b)
      0
      (+ (fn a) (sum fn (+ a 1) b))))

* To remember: a function wrapped in parens is applying it but without parens it is simply referring to it
* Lecturer uses random names:
  -> 'se' instead of 'cons'
  -> 'first' instead of 'car'
  -> 'bf' instead of 'cdr'

* High school mathematics was a lie.
  -> Did not use x -> 2x + 6, used x = 2x + 6 therefore not able to differentiate numbers from functions

* f(x) = 2x + 6 => (define (f x) (+ (* 2 x) 6))
* x -> 2x + 6 => (lambda (x) (+ (* 2 x) 6))

* First class data can be:
  - value of a variable
  - argument to a procedure
  - return value from a procedure, i.e,
  - member of an aggregate (i.e. a sentence/list of words)

* Lambda isn't invoked, but the procedure it returns
* Learn about lambda calculus
* return value from a procedure:

(define (compose f g)
  (lambda (x)
    (f (g x))))
(define second (compose car cdr))
This procedure returns the second member of a list and has no data in it besides functions