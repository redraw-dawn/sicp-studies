## 1.3.1 - Procedures as Arguments

The following procedures generate sums:

sum:
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

cubes:
(define (cube x) (* x x x))
(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

This method moves towards pi/8 slowly:
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

These methods share a common underlying process. They differ in:
- name of procedure
- function to compute term to be added
- function that increments a

(define (<name> a b)
  (if (> a b)
      0
      (+ (<term> a)
       (<name> (<next> a) b))))

The presence of a pattern means it is highly likely an abstraction can be made.

N.B. this abstraction is similiar in theory to mathematicians identifying the abstraction of a summation of a series and inventing sigma notation to express it.

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

* sum takes the lower and higher bounds (a and b) together w/ procedures next and term, i.e.

(define (inc n) (+ n 1))
(define (sum-cubes2 a b)
  (sum cube a inc b))

(define (identity x) x)
(define (sum-integers2)
  (sum identity a inc b))

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

* a method for defining the definite integral of a function f between the limits of a and b is:

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))


## 1.3.2 Constructing Procedures Using `Lambda`

* `lambda` is a special form which creates procedures, i.e. (lambda (x) (+ x 1)) for incrementing
* `lambda` creates procedures the same way as `define` except they are not associated with a name in the environment
* You can use define with lambda, i.e.: (define (inc n) (+ n 1)) is the same as (define inc (lambda n) (+ n 1))
* In any context where a procedure name would be used, a lambda can be

* `let` can be used to create local variables, i.e.

function to compute:
f(x, y) = x(1 + xy)^2 + y(1 - y) + (1 + xy)(1 - y)

could be simplified by:
a = 1 + xy
b = 1 - y

f(x, y) = xa^2 + yb + ab

In writing a method to compute this procedure, we'd like to include names for the intermediate quantities a & b.

Can do this through an auxilliary procedure, i.e.

(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
  (f-helper (+ 1 (* x y))
            (- 1 y)))

Could make f use a `lambda` to express an anonymous procedure to bind them, i.e.

(define (f x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
   (+ 1 (* x y))
   (- 1 y)))

`let` exists as a special form to make the above use of lambda more convenient.

(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))

The general form of a let expression is:

(let ((<var1> <exp1>)
      (<var2> <exp2>)
      ...
      (<varn> <expn>))
   <body>)

* First part of let is name/value pairs
* When the let is evaluated, each name is associated with the value of the corresponding expression.
* The body is evaluated with these names bound as local variables
* `let` is interpreted as alternate syntax for:

((lambda (<var1> ...<varn>)
    <body>)
 <exp1> ... <expn>)

* `let` is syntactic sugar for the above `lambda` application
* scope of `let` is the body of the `let`
* the variable values are computed outside of the let
  -> cannot use one in the defintion of another esp when using variables which share names with others from outside the scope

* You can also use internal definitions (`define`s) but it is preferred to use `let` for variables and `define` for procedures

## 1.33 - Procedures as General Methods

#### Finding roots of equation with half-interval method

* Finds root of an equation (`f(x) = 0`) where `f(a)` < 0 < `f(b)`
* To start, make `x` the average of `a` and `b`.
  -> If result < 0 then f has a 0 between `x` and `b`; else it's between `a` and `x`.
* Reduce the interval constantly until it is deemed 'close enough'
* As the interval reduces by half each time the number of steps grows as `<theta>(log( L/T))`
  -> where L is length of original interval and T is error tolerance (what we consider 'close enough')

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

As search relies us to put in values which return negative and positive when applied to f it can be awkward to use.
Therefore we use as:

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))

