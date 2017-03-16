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
  (< (abs (- guess prev-guess)) 0.001))

(define (sqrt-iter-new guess prev-guess x)
  (if (good-enough-new guess prev-guess)
      guess
      (sqrt-iter-new (improve guess x) guess x)))```j3

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
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

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

;; Exercise 1.10
;; Ackermann's function
(define (A x y)
  (cond ((= y 0) 0)
	((= x 0) (* 2 y))
	((= y 1) 2)
	(else (A (- x 1)
		 (A x (- y 1))))))

(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (2))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (4)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (8))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (16)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (32))))))
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
(A 0 (A 0 (A 0 (A 0 (64)))))
(A 0 (A 0 (A 0 (A 0 64))))
(A 0 (A 0 (A 0 (128))))
(A 0 (A 0 (A 0 128)))
(A 0 (A 0 (256)))
(A 0 (A 0 256))
(A 0 (512))
(A 0 512)
1024

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 8))
(A 1 16)
(A 0 (A 1 15))
(A 0 (A 0 (A 1 14)))
(A 0 (A 0 (A 0 (A 1 13))))
(A 0 (A 0 (A 0 (A 0 (A 1 12)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
...
(A 1 16) = 2^16
65536



(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))
(A 2 (A 1 (A 1 1)))
(A 2 (A 1 2))
(A 2 (A 1 (A 1 1)))
(A 2 (A 1 2))
(A 2 (A 0 (A 1 1)))
(A 2 (A 0 2))
(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 1 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 8))
(A 1 16) = 2^16
65536


;; Give concise mathematical definitions for the following
(define (f n) (A 0 n))
;; = 2n
(define (g n) (A 1 n))
;; = 2^n
(define (h n) (A 2 n))
;; = 2^(n^2)
(define (k n) (* 5 n n))
;; = 5n^2

;; Exercise 1.11
;; A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3.
;; Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.
;; recursive
(define (f n)
  (if (< n 3) n
  (+ (f (- n 1)) 
    (* 2 (f (- n 2)))
      (* 3 (f (- n 3))))))

;; iterative
(define (f n))
(define (f-iter n state-variables))

;; Exercise 1.12
;; pascals triangle
;; if x/y == 0 || 1, then 1. if y > x then 0
(define (pascals x y)
  (cond
   ((> x y) 0)
   ((= x 0) 1)
   ((= y 0) 1)
   ((= x y) 1)
   (else
    (+ (pascals x (- y 1))
       (pascals (- x 1) (- y 1))))))

;; tail-recursive method to work out counting change
(define one-coin-changer
  (lambda (coin amount)
    (cond
    ((= amount 0) #t)
    ((> 0 amount) #f)
    (else
     (one-coin-changer coin (- amount coin))))))

(define get-coin-value
  (lambda (coin-num)
    (cond
     ((= 0 coin-num) 1)
     ((= 1 coin-num) 2)
     (else 5))))

(define get-num-of-ways
  (lambda (coin-num amount)
    (tail-recursive-coin-changer coin-num amount coin-num amount 0)))

(define is-below-or-equal-to-zero?
  (lambda (num num1)
    (<= (- num num1) 0)))

;; steps:
;; 1. go through all coins from max-amount
;; 2. minus working-coin from max-amount
;; 3. if working-coin is 0 then minus max-coin from amount and repeat from step 1
;; \-> conditions:
;;   * if you minus max-coin from max-amount and (or (= it 0) (< it 0)) then (- max-coin 1)

(define tail-recursive-coin-changer
  (lambda (working-coin working-amount coin-to-minus max-coin original-amount ways-of-change)
    (cond
     ((= coin-to-minus 0) ways-of-change)
     ((< working-coin 0)
      (if ((is-below-or-equal-to-zero? working-amount coin-to-minus))
	  (call again with decremented coin-to-minus)
	  (call again with (- coin-to-minus working-amount))))
     (else
      (if (one-coin-changer working-coin working-amount)
	  (increment ways-of-change && call again w/ decremented working-coin)
	  (call again w/ decremented working-coin))))))
