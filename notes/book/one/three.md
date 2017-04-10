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


