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
