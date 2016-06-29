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
;; applicative order would not result in eternal loop when it got to (p)

