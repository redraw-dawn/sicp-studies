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
     (one-coin-changer coin (- amount (get-coin-value coin "3")))))))

(define get-coin-value
  (lambda (coin-num called-from)
    (cond
     ((= 0 coin-num) 1)
     ((= 1 coin-num) 2)
     ((= 2 coin-num) 5)
     (else error (string "wrong coin value: " coin-num ". position: " called-from)))))

(define get-num-of-ways
  (lambda (coin-num amount)
    (coin-change-iter coin-num amount coin-num coin-num coin-num amount 0)))

(define cannot-minus-coin?
  (lambda (num num1)
    (<= (- num num1) 0)))

(define --
  (lambda (num)
    (- 1 num)))

(define ++
  (lambda (num)
    (+ 1 num)))

(define coin-change-iter
  (lambda (working-coin working-amount coin-to-minus max-minus max-coin original-amount ways-of-change)
    (cond
     ((= max-minus 0) ways-of-change)
     ((< working-coin 0)
      ;; insert under here
      (if (= coin-to-minus 0)
	  (coin-change-iter (-- max-coin) original-amount (-- max-minus) (-- max-minus) (-- (-- max-coin)) original-amount ways-of-change)
	  (if (cannot-minus-coin? working-amount (get-coin-value coin-to-minus (string "1: " max-minus)))
	      (coin-change-iter (-- max-coin) working-amount (-- coin-to-minus) max-minus (-- max-coin) original-amount ways-of-change)
	      (coin-change-iter max-coin (- working-amount (get-coin-value coin-to-minus "2")) coin-to-minus max-minus max-coin original-amount ways-of-change)))
      ;; insert ends here
      )
     (else
      (if (one-coin-changer working-coin working-amount)
	  ;; -- working coin && ++ ways of change
	  (coin-change-iter (-- working-coin) working-amount coin-to-minus max-minus max-coin original-amount (++ ways-of-change))
	  ;; -- working coin
	  (coin-change-iter (-- working-coin) working-amount coin-to-minus max-minus max-coin original-amount ways-of-change))))))

;; working-coin (-- (-- max-minus))  | (-- max-coin)
;; working-amount original-amount    | working-amount
;; coin-to-minus (-- max-minus)      | (-- coin-to-minus)
;; max-minus (-- max-minus)          | max-minus
;; max-coin (-- (-- max-minus))      | (-- max-coin)
;; original-amount original-amount   | original-amount
;; ways-of-change ways-of-change     | ways-of-change


;; Exercise 1.13

;; i'll come back to counting change algorithm & this ^

;; Exercise 1.14

;; Space grows proportionally with tree depth which is affected by the input hence, O(n)
;; Steps grow linearly with n? unsure how to do this

;; Exercise 1.15

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  ;; added logging
  (display angle) (newline)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; a) How many times is sine called when angle equals 12.15

;; (sine 12.15)
;; 12.15
;; 4.05
;; 1.3499999999999999
;; .44999999999999996
;; .15
;; 4.9999999999999996e-2
;Value: -.39980345741334

;; Calls sine for each application of fn besides the last, so 5 times

;; b) What is order of growth of steps and space?

;; the value passed to sine would have to triple to add another step.
;; the space required grows with tripling as well. only the call to p is deferred.
;; They both are O(log n) according to:
;; http://www.billthelizard.com/2009/12/sicp-exercise-115-calculating-sines.html
;; I need to study algorithms and maths again :O

;; Exercise 1.16 Iterative Exponentiaton Procedure
;; Use the observation that (b^(n/2))^2 == ((b^2)^(n/2))

;; iterative but theta(n) for steps, not theta(log n)
(define (fast-expt a b n)
  (if (= n 0)
      a
      (fast-expt (* a b) b (- n 1))))

(define (even? n)
  (= 0 (modulo (abs n) 2)))
;; make an internal loop procedure that removes the state variable a from initial method call

(define (fast-expt a b n)
  (cond ((= n 0) a)
	((even? n)
	 (fast-expt a (square b) (/ n 2)))
	(else
	 (fast-expt (* a b) b (- n 1)))))

(define (logn-expt b n)
  (define (even? n)
    (= 0 (modulo (abs n) 2)))
  (define (square x) (* x x))
  (define (loop a b n)
    (cond ((= n 0) a)
	  ((even? n)
	   (fast-expt a (square b) (/ n 2)))
	  (else
	   (fast-expt (* a b) b (- n 1)))))
  (loop 1 b n))

;; Ex 1.17 Multiplication with log n steps
(define (double n) (* 2 n))
(define (halve n) (/ n 2))
(define (even? n)
  (= 0 (modulo (abs n) 2)))

(define (fast-mult a b)
  (cond ((= 0 b) 0)
	((= 1 b) a)
	((even? b) (fast-mult (double a) (halve b)))
	(else (+ a (fast-mult a (- b 1))))))

;; Ex 1.18 Iterative multiplication with addition
(define (double n) (* 2 n))
(define (halve n) (/ n 2))
(define (even? n)
  (= 0 (modulo (abs n) 2)))

(define (fast-multi a b n)
  (cond ((= n 0) a)
	((even? n)
	 (fast-multi a (double b) (halve n)))
	(else
	 (fast-multi (+ a b) b (- n 1)))))

(define (logn-multi b n)
  (define (loop a b n)
    (cond ((= n 0) a)
	  ((even? n) (fast-multi a (double b) (halve n)))
	  (else (fast-multi (+ a b) b (- n 1)))))
  (loop 0 b n))

;; Ex 1.19
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))      ; compute p'
                   (+ (square q) (* 2 p q))      ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(define (square x) (* x x))

;; Ex 1.20 Normal Order VS Applicative Order
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; Normal Order
(gcd 206 40)

(if (= (remainder 206 40) 0) ;; evaluates * 1; 6
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= 0 (remainder 40 (remainder 206 40))) ;; evaluates * 2; 4 & 6
    (remainder 206 40)
    (gcd
     (remainder 40 (remainder 206 40))
     (remainder
      (remainder 206 40)
      (remainder 40 (remainder 206 40)))))
;; a = (remainder 40 (remainder 206 40))
;; b = (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))

 ;;      2            6,                4,            6 * 4
(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder
	  (remainder 206 40)
	  (remainder 40 (remainder 206 40)))
	 (remainder
	  (remainder 40 (remainder 206 40))
	  (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
;; a = (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;; b = (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

;;             2             4             6                  2           6                  4            6 * 7
(if (= 0 (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
    ;;      2           6                 4            6 * 4
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
    (gcd
     (remainder
      (remainder 40 (remainder 206 40))
      (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
     (remainder
      (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
      (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

;; evaluates 18 times. that was a mission. don't know if it was worth it.

;; Applicative Order
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
2

;; Exercise 1.21
;; 199 -> 199
;; 1999 -> 1999
;; 19999 -> 7

;; Exercise 1.22
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;; Write a procedure search-for-primes that checks the primality of consecutive odd integers in a specified range
(define (even? n)
  (= 0 (modulo n 2)))

(define (search-for-primes lower upper)
  (cond ((> lower upper)
	 (newline) (display "fini"))
	((even? lower)
	 (search-for-primes (+ 1 lower) upper))
	(else
	 (timed-prime-test lower)
	 (search-for-primes (+ 2 lower) upper))))

;; reused method from 1.2.6 searching for divisors by succesive integers
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (define (square x) (* x x))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

;; there's no way to get runtime value in scheme... There is in dr racket and chicken scheme. All my results show 0

;; Exercise 1.23 define next procedure for smallest-divisor to not check even numbers
(define (next n)
  (cond ((= 2 n) 3)
	((even? n) (+ n 1))
	(else (+ n 2))))

;; as above

;; Exercise 1.24
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 50)
      (report-prime (- (runtime) start-time))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

;; insert into smallest-divisor helper method
(define (find-divisor n test-divisor)
  (define (square x) (* x x))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

;; Exercise 1.25 difference between fast-expt and expmod
;; Using expmod is faster due to the technique used which according to the notes
;; 'This technique is useful because it means we can perform our computation without
;; ever having to deal with numbers much larger than m'

;; Exercise 1.26
;; modified version which is slower than original
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

;; Generates a tree recursive process when exp is even which results in an exponential number of steps

;; Exercise 1.27 test fermat numbers
(define (square x)
  (* x x))

(define (even? n)
  (= 0 (modulo n 2)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
		    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
		    m))))

(define (complete-fermat n)
  (define (fermat-test a)
    (= (expmod a n n) a))
  (define (loop x)
    (newline) (display x)
    (cond ((= x n) #t)
	  ((fermat-test x) (loop (+ x 1)))
	  (else #f)))
  (loop 1))

;; Exercise 1.28 Miller-Rabin Test
;; - if n is a prime and a is a positive number less than n, a^(n-1) is congruent to (modulo 1 n)
;; when performing expmod we must check to see if we have a "nontrivial square root of 1 modulo n", i.e. a number not equal to 1 or (- n 1) whose square is equal to 1 modulo n
;; if this nontrivial ... exists then n is not prime
;; hint: have expmod return 0

(define (miller-rabin n)
  (define (try-it a)
    (= 1 (expmod a (- n 1) n)))
  (try-it (+ 2 (random (- n 2)))))

(define (non-trivial-root x n)
  (cond ((= 1 x) #f)
	((= (- n 1) x) #f)
	(else (= 1 (modulo (square x) n)))))

(define (square-with-check x n)
  (if (non-trivial-root x n)
      0
      (modulo (square x) n)))

(define (even? n)
  (= 0 (modulo n 2)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
	 (square-with-check (expmod base (/ exp 2) m) m))
         (else
	  (remainder (* base (expmod base (- exp 1) m))
		     m))))

(define (tester-list)
  (define (tester n)
    (if (= n 100)
	'()
	(cons n (tester (+ n 1)))))
  (tester 3))

(define (cmap lat fn)
  (cond ((null? lat) '())
	(else
	 (cons (fn (car lat))
	       (cmap (cdr lat) fn)))))

;; under 103...
(define (test-under-hundred x)
  (cmap (tester-list) miller-rabin))

(define (return-primes lat)
  (if (null? lat)
      `()
      (if (miller-rabin (car lat))
	  (cons (car lat) (return-primes (cdr lat)))
	  (return-primes (cdr lat)))))

(define primes-in-tester-list
  (return-primes (tester-list)))

;; Exercise 1.29 Simpson's Rule
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (inc n) (+ n 1))

(define (simpsons f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (term k)
    (* (cond ((odd? k) 4)
	     ((or (= k 0) (= k n)) 1)
	     (else 2))
       (y k)))
  (/ (* h (sum term 0 inc n)) 3))

(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

;; Exercise 1.30
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

;; Exercise 1.31
(define (product-tail term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (* (term a) result))))
  (iter a 1))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
	 (product term (next a) next b))))

(define (factorial n)
  (define (identity x) x)
  (define (inc n) (+ 1 n))
  (product identity 1 inc n))

;; John Wallis -> https://en.wikipedia.org/wiki/Wallis_product
;; 2n/(2n - 1) * 2n/(2n + 1)
(define (jw-pi n)
  (define (double x) (* 2.0 x))
  (define (term a)
    (* (/ (double a) (- (double a) 1))
       (/ (double a) (+ (double a) 1))))
  (define (inc y) (+ 1 y))
  (product term 1 inc n))

;; Exercise 1.32
;;(accumulate combiner null-value term a next b)
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))
(define (product term a next b)
  (accumulate * 1 term a next b))

(define (accumulate-tail combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (sum-tail term a next b)
  (accumulate-tail + 0 term a next b))
(define (product-tail term a next b)
  (accumulate-tail * 1 term a next b))

;; Exercise 1.33
;; filtered-accumulate
(define (filtered-accumulate-tail combiner null-value term a next b filter)
  (define (iter a result)
    (cond ((> a b) result)
	  ((not (filter a)) (iter (next a) result))
	  (else (iter (next a) (combiner (term a) result)))))
  (iter a null-value))

(define (filtered-accumulate combiner null-value term a next b filter)
  (cond ((> a b) null-value)
	((filter a)
	 (combiner (term a) (filtered-accumulate combiner null-value term (next a) b filter)))
	(else
	 (filtered-accumulate combiner null-value term (next a) b filter))))

;; made for printing in repl
(define (reverse ls)
  (define (loop ls result)
    (cond ((null? ls) result)
	  (else
	   (loop (cdr ls) (cons (car ls) result)))))
  (loop ls '()))

(define (member? n list)
  (cond ((null? list) #f)
	((= n (car list)) #t)
	(else (member? n (cdr list)))))

(define (get-non-primes original current max result)
  (define (inc n) (+ 1 n))
  (cond ((> original max) result)
	((> current max)
	 (get-non-primes (inc original) (* 2 (inc original)) max result))
	((member? current result)
	 (get-non-primes original (+ current original) max result))
	(else
	 (get-non-primes original (+ current original) max (cons current result)))))

(define (get-primes-under-100)
  (define non-primes (get-non-primes 2 4 100 '()))
  (define (loop n result)
    (cond ((> n 100)
	   result)
	  (else (loop (+ n 1) (if (member? n non-primes) result (cons n result))))))
    (loop 2 '()))

(define (prime? n)
  (define x (get-non-primes 2 4 100 '()))
  (not (member? n x)))

(define (square x) (* x x))

;; the sum of the squares of the prime numbers in the interval a to b
(define (sum-of-squared-primes a b)
  (define min-a
    (if (< a 3) 2 a))
  (define list-of-non-primes
    (get-non-primes min-a (* 2 min-a) b '()))
  (filtered-accumulate-tail + 0 square a inc b prime?))

;; 1.33 b - the product of all the positive integers less than n that are relatively prime to n

(define (my-modulo num reduce-by)
  (define result (- num reduce-by))
  (cond
   ((< 0 result) (my-modulo result reduce-by))
   ((= 0 result) result)
   (else num)))

(define (co-prime? a b)
  (cond
   ((or (= 1 a) (= 1 b)) #t)
   ((= a b) #f)
   (else
    (if (> a b)
	(co-prime? (- a b) b)
	(co-prime? a (- b a))))))

(define (sum-of-co-prime-numbers-under n)
  (define (inc n) (+ 1 n))
  (define (identity x) x)
  (define (co-prime-check x) (co-prime? n x))
  (filtered-accumulate-tail + 0 identity 1 inc n co-prime-check))

;; to test call (= (sum-of-co-prime-numbers-under n) (apply + (list-co-primes-under n)))
(define (list-co-primes-under n)
  (define (iter current)
    (cond
     ((< current n)
      (if (co-prime? current n)
	  (cons current (iter (+ current 1)))
	  (iter (+ current 1))))
     (else '())))
  (iter 1))

;; 1.34
(define (f g)
  (g 2))
;; what happens when you apply f to f?
(f f)
(f (lambda g) (g 2))
;; apply 2 to 2

;; 1.35
;; Golden ratio is a fixed point of the transformation x -> 1 + 1/x

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average list)
  (define (inc n) (+ 1 n))
  (define (loop list length to-divide)
    (if (null? list)
	(/ to-divide length)
	(loop (cdr list) (inc length) (+ (car list) to-divide))))
  (loop list 0 0.0))

(define golden-ratio
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))

;; 1.36
;; Add logging & damping
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display next) (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define without-damping
  (fixed-point (lambda (x) (/ (log 1000) (log x))) 20.0))

(define with-damping
  (fixed-point (lambda (x) (/ (+ x (/ (log 1000) (log x))) 2)) 20.0))

;; 1.37
;; continued-fraction to evaluate k
(define (cont-frac n d k)
  (define (inc n) (+ 1 n))
  (define (loop i)
    (if (= i k)
	(/ (n k) (d k))
	(/ (n i) (+ (d i) (loop (inc i))))))
  (loop 1))

;; To get 1/golden-ratio accurate to 4dp, k must equal 10 with n & d both being equal to (lambda (i) 1.0)

;; 1.37b - if done recursively do iteratively, and vice versa
(define (cont-frac-iter n d k)
  (define (loop i result)
    (if (< i 0)
	result
	(loop (- i 1) (/ (n i) (+ (d i) result))))
    )
  (loop (- k 1) (/ (n k) (d k))))

;; Build result from other end as you cannot add to the bottom of the fraction


;; 1.38
;; Approximate e according to Euler's expansion
(define (eulers-e k)
  (define (d-fn i)
    (if (= 2 (modulo i 3))
	(* 2 (/ (+ i 1) 3.0))
	1))
  (+ 2 (cont-frac (lambda (i) 1.0) d-fn k)))

;; Have to add + 2 as the method results in e - 2

;; 1.39
;; Approximate J.H. Lambert's tan function
(define (tan-cf x k)
  (define (square x) (* x x))
  (define (n-fn i) (if (= i 1) x (- (square x))))
  (define (d-fn i) (- (* 2 i) 1))
  (cont-frac n-fn d-fn 20.0))

;; 1.40
;; Define cubic to be used with newton's method which approximates zero of x^3 + ax^2 + bx + c.

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (define (square c) (* c c))
  (define (cube d) (* d d d))
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))

;; 1.41
;; Define a procedure, double, which takes an procedure of one argument
(define (double f)
  (lambda (x)
    (f (f x))))

;; (((double (double double)) inc) 5) returns 21

;; 1.42
;; Define a procedure, compose, which applies f after g, i.e. x -> f(g(x))

(define (compose f g)
  (lambda (x)
    (f (g x))))

;; 1.43
;; Define a procedure, repeated, which takes f, a procedure, and n, a number, and returns a procedure that applies f n times

(define (repeated f n)
  (define (repeat x n)
    (if (= n 0)
	x
	(f (repeat x (- n 1)))))
  (lambda (x)
    (repeat x n)))

;; online solution which is nicer than mine & uses compose from ex1.42
;; returns a f (procedure) to apply to compose procedure rather than building return value like mine
(define (repeated f x)
  (if (= x 1)
      f
      (compose f (repeated f (- x 1)))))

;; 1.44
;; If f is a procedure and dx is some small number, smoothing is when you average f(x - dx), f(x) and f(x + dx)
;; 1. Define a procedure, smooth, which takes a procedure which computes f and returns a prcocedure that returns a smoothed f.
;; 2. Show how to get the n-fold smoothed function using smooth and repeated

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))
	  (f x)
	  (f (+ x dx)))
       3
       )))

(define (n-fold-smooth f dx n)
    (repeated (smooth f dx) n))


;; 1.45
;; Make a procedure to find the n-th root using fixed-point, average-damp and repeated
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average a b)
  (/ (+ a b) 2))

(define (repeated f x)
  (if (= x 1)
      f
      (compose f (repeated f (- x 1)))))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;; expt is built in exponential function (which takes two args). read docs

;; testing by (nth-root n (expt x n))

;; 1st test goes till n = 8 (x^8)
(define (nth-root n x)
  (fixed-point
   ((repeated average-damp 2)
    (lambda (y) (/ x (expt y (- n 1)))))
   1.0))


;; 2nd test goes till n = 16
(define (nth-root n x)
  (fixed-point
   ((repeated average-damp 3)
    (lambda (y) (/ x (expt y (- n 1)))))
   1.0))

;; 3rd test goes till n = 32
(define (nth-root n x)
  (fixed-point
   ((repeated average-damp 4)
    (lambda (y) (/ x (expt y (- n 1)))))
   1.0))

;; n can be evauluated up until it reaches 2^(repeat + 1)

;; Final
(define (is-less-than-what-power-of-two x)
  (define (iter x n)
    (if (< x (expt 2 n))
	n
	(iter x (+ n 1))))
  (iter x 0))

(define (repeat-n n)
  (is-less-than-what-power-of-two n))

(define (nth-root n x)
  (fixed-point
   ((repeated average-damp (repeat-n n))
    (lambda (y) (/ x (expt y (- n 1)))))
   1.0))

;; 1.46
;; make iterative improve which takes as args a procedure to check if answer is good
;; enough and another to improve guess. returns a procedure which takes a guess

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (let ((result (improve guess)))
      (display result) (newline)
      (if (good-enough? result)
	  result
	  ((iterative-improve good-enough? improve) result)))))

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) 0.00001))
    (lambda (guess) (/ (+ guess (/ x guess)) 2)))
   1.0))

(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (x)
      (< (abs (- x (f x))) 0.00001))
    f)
   first-guess))
