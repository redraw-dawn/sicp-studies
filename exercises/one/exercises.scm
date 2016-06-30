;; exercise 1.2
(/
 (+ 5
    (- 2
       (- 3
          (+ 6
             (/ 1 5)
             )
          )
       )
    )
 
 (* 3
    (- 6 2)
    (- 2 7)
    )
 )
;; exercise 1.3
(define (square x) (* x x))
(define (sumOfSquares a b) (+ (square a) (square b)))
(define (twoOfThreeSums a b c)
  (cond (and (> a b) (> b c)) (sumOfSquares a b)
        (and (> b a) (> c a)) (sumOfSquares b c)
        else (sumOfSquares a c)))
;; exercise 1.4
;; can use a test to determine which operator to apply to operands

;; exercise 1.5
;; applicative order would not result in eternal loop when it got to (p)

;; exercise 1.6
;; will be called indefinitely as only cond special form stops the evaluation at the predicate

;; exercise 1.7
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)
      ))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; start guessing square roots with 1
(define (sqrt x)
  (sqrt-iter 1.0 x))

;; The test good-enough? is bad for very small numbers as it 0.001 may not be small enough a difference
(sqrt 1.02000012312312)
;; => 1.01000006156156
(square 1.010000006156156)
;; => 1.0201000124354351

;; the test won't be adequate for large numbers because it is too minute a difference and will not return a value
;; e.g.
(sqrt 99991912481924812)
