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
      ((+ <term> a)
       (<name> (<next> a) b))))


