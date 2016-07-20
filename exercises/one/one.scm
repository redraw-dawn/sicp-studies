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

(define (good-enough-new guess prev-guess)
  (< (abs (- guess prev-guess) ) 0.001))

(define (sqrt-iter-new guess prev-guess x)
  (if (good-enough-new guess prev-guess)
      guess
      (sqrt-iter-new (improve guess x) guess x)
      ))

(define (sqrt-new x)
  (sqrt-iter-new 1.0 0 x))
;; the test won't be adequate for large numbers because it is too minute a difference and will not return a value
;; e.g.
(sqrt 99991912481924812)

;; Exercise 1.8
(define (cube-iter guess prev-guess x)
  (if (good-enough-new guess prev-guess)
      guess
      (cube-iter (cube-improve guess x) guess x)
      ))

(define (cube-improve guess x)
  (/ (+ (/ x
	   (square guess))
	(* 2 guess))
   3))

(define (cbrt x)
  (cube-iter 1.0 0 x))

;; Exercise 1.9
;; Assumptions for how the following methods work. ignore + defined below
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

;; method 1
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

;; method 1 working
(+ 4 5)
(if (= 4 0)
    5
    (inc (+ (dec 4) 5)))
(inc (+ (- 4 1) 5))
(inc (+ 3 5))
(inc (if (= 3 0)
	 5
	 (inc (+ (dec 3) 5))))
(inc (inc (+ (dec 3) 5)))
(inc (inc (+ (- 3 1) 5)))
(inc (inc (+ 2 5)))
(inc (inc (if (= 2 0)
	 5
	 (inc (+ (dec 2) 5)))))
(inc (inc (inc (+ (dec 2) 5))))
(inc (inc (inc (+ (- 2 1) 5))))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (if (= 1 0)
		   5
		   (inc (+ (dec 1) 5))))))
(inc (inc (inc (inc (+ (- 1 1) 5)))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc (if (= 0 0)
			5
			(inc (+ (dec 0) 5)))))))

(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
;; this process is recursive

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

;; method 2 working
(+ 4 5)
(if (= 4 0)
    5
    (+ (dec 4) (inc 5)))
(+ (dec 4) (inc 5))
(+ 3 6)
(if (= 3 0)
    6
    (+ (dec 3) (inc 6)))
(+ (dec 3) (inc 6))
(+ 2 7)
(if (= 2 0)
    7
    (+ (dec 2) (inc 7)))
(+ (dec 2) (inc 7))
(+ 1 8)
(if (= 1 0)
    8
    (+ (dec 1) (inc 8)))
(+ (dec 1) (inc 8))
(+ 0 9)
(if (= 0 0)
    9
    (+ (dec 0) (inc 9)))
9
;; this process is iterative
