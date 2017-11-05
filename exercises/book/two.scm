;; Exercise 2.1
;; Put GCD computation into make-rat
(define (make-rat n d)
  (define (correct-sign x)
    (cond
     ((and (< n 0) (< d 0)) (- x))
     ((and (> n 0) (< d 0)) (- x))
     (else x)))
  (let ((numerator (correct-sign n))
	 (denominator (correct-sign d))
	 (g (gcd n d)))
    (cons (/ numerator g) (/ denominator g))))

;; Exercise 2.2
;; Write segment and point constructors and selectors
;; Write procedure to compute midpoint of a segment
(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (midpoint-segment segment)
  (define (add-points segment getter)
    (+ (getter (start-segment segment))
       (getter (end-segment segment))))
  (let ((x-avg (/ (add-points segment x-point) 2))
	(y-avg (/ (add-points segment y-point) 2)))
    (make-point x-avg y-avg)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; Exercise 2.3
;; 1. Write constructors & selectors for a rectangle, procedures for perimeter calculation and area of rectangle

;; CONSTRUCTOR
;; Rectangle represented as pair of its two long sides
(define (make-rectangle p1 p2 p3 p4)
  (cons (make-segment p1 p2) (make-segment p3 p4)))

;; SELECTORS
(define (long-side rectangle)
  (car rectangle))

(define (short-side rectangle)
  (make-segment
   (end-segment (car rectangle))
   (start-segment (cdr rectangle))))

;; PROCEDURES A LEVEL OF ABSTRACTION AWAY
(define (segment-length segment)
  (define (segment-is-vertical? segment)
    (= (x-point (start-segment segment)) (x-point (end-segment segment))))
  (define (get-length segment getter)
    (abs (- (getter (start-segment segment)) (getter (end-segment segment)))))
  (if (segment-is-vertical? segment)
      (get-length segment y-point)
      (get-length segment x-point)))

(define (perimeter rectangle)
  (* 2
     (+ (segment-length (long-side rectangle))
	(segment-length (short-side rectangle)))))

(define (area rectangle)
  (* (segment-length (long-side rectangle))
     (segment-length (short-side rectangle))))

;; 2. Change constructor and selectors and check if procedures are abstracted enough that they still work
(define (make-rectangle p1 p2 p3 p4)
  (cons p1 (cons p2 (cons p3 p4))))

(define (long-side rectangle)
  (make-segment
   (car rectangle)
   (car (cdr rectangle))))

(define (short-side rectangle)
  (make-segment
   (car rectangle)
   (cdr (cdr (cdr rectangle)))))


;; Exercise 2.4
;; a) Verify (car (cons x y)) works for any object x y
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(car (cons 1 2))
(car (lambda (x) (m 1 2)))
((lambda (m) (m 1 2)) (lambda (p q) p))
((lambda (p q) p) 1 2)
1

;; b) Write cdr
(define (cdr z)
  (z (lambda (p q) q)))

;; Exercise 2.5
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (is-even x)
  (= 0 (modulo x 2)))

(define (reduce-pair pair base count)
  (if (= 0 (modulo pair base))
      (reduce-pair (/ pair base) base (+ 1 count))
      count))

(define (car c)
  (reduce-pair c 2 0))

(define (cdr c)
  (reduce-pair c 3 0))

;; Exercise 2.6

(define zero
  (lambda (f)
    (lambda (x) x)))

(define (zero f)
  (lambda (x) x))

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

(add-1 zero)
(add-1
 (lambda (f)
   (lambda (x) x)))

(lambda (f)
  (lambda (x)
    (f (((lambda (f)
	   (lambda (x) x)) f) x))))

(lambda (f)
  (lambda (x)
    (f ((lambda (x) x) x))))

(lambda (f)
  (lambda (x)
    (f x)))

(define one
  (lambda (f)
    (lambda (x)
      (f x))))

(add-1 one)
(add-1
 (lambda (f)
   (lambda (x)
     (f x))))

((lambda (n)
   (lambda (f)
     (lambda (x)
       (f ((n f) x)))))
 (lambda (f)
   (lambda (x)
     (f x))))

(lambda (f)
  (lambda (x)
    (f (((lambda (f)
	   (lambda (x)
	     (f x)))
	 f)
	x))))

(lambda (f)
  (lambda (x)
    (f ((lambda (x)
	  (f x)) x))))

(lambda (f)
  (lambda (x)
    (f (f x))))

(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))

;; Extended Exercise 2.1.4
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-interval a b)
  (cons a b))

;; Exercise 2.7
;; Define upper-bound and lower-bound for the intervals
(define (get-bound interval test)
  (let ((x (car interval))
	(y (cdr interval)))
    (if (test x y)
	x
	y)))

(define (lower-bound interval)
  (get-bound interval <))

(define (upper-bound interval)
  (get-bound interval >))

;; Exercise 2.8
;; Define sub-interval
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
		 (- (upper-bound x) (upper-bound y))))

;; Exercise 2.9
;; Show width is a function of the widths being added/subtracted but not multiplied/divided
(define (width interval)
  (let ((distance (- (upper-bound interval) (lower-bound interval))))
    (/ distance 2)))

(define x (make-interval 2 8))
;; (width x) = 3
(define y (make-interval 3 7))
;; (width y) = 2

(define add (add-interval x y))
;; (width add) = 5

(define diff (sub-interval x y))
;; (width diff) = 1

(define mul (mul-interval x y))
;; (width mul) = 25

(define div (div-interval x y))
;; (width div) = 1.1904761904761905

;;Exercise 2.10
;; Handle interval of length 0 by throwing error
(define (make-interval a b)
  (if (= a b)
      (error "Must have a length greater than zero")
      (cons a b)))

;; Exercise 2.11
;; Rewrite mul-interval with end point tests to minimise multiplications
;; [+, +] * [+, +]
;; [+, +] * [-, +]
;; [+, +] * [-, -]

;; [-, +] * [+, +]
;; [-, +] * [-, +]
;; [-, +] * [-, -]

;; [-, -] * [+, +]
;; [-, -] * [-, +]
;; [-, -] * [-, -]
(define (is-negative a)
  (< a 0))
(define (is-positive a)
  (not (is-negative a)))

(define (mul-interval-case x y)
  (let ((xlo (lower-bound x))
	(xhi (upper-bound x))
	(ylo (lower-bound y))
	(yhi (upper-bound y)))
    (cond
     ;; [+, +] & [+, +]
     ((and (is-positive xlo)
	   (is-positive xhi)
	   (is-positive ylo)
	   (is-positive yhi))
      (make-interval (* xlo ylo)
		     (* xhi yhi)))
     ;; [+, +] & [-, +]
     ((and (is-positive xlo)
	   (is-positive xhi)
	   (is-negative ylo)
	   (is-positive yhi))
      (make-interval (* xhi ylo)
		     (* xhi yhi)))
     ;; [+, +] & [-, -]
     ((and (is-positive xlo)
	   (is-positive xhi)
	   (is-negative ylo)
	   (is-negative yhi))
      (make-interval (* xhi ylo)
		     (* xlo yhi)))
     ;; [-, +] & [+, +]
     ((and (is-negative xlo)
	   (is-positive xhi)
	   (is-positive ylo)
	   (is-positive yhi))
      (make-interval (* xlo yhi)
		     (* xhi yhi)))
     ;; [-, +] & [-, +]
     ((and (is-negative xlo)
	   (is-positive xhi)
	   (is-negative ylo)
	   (is-positive yhi))
      (make-interval (min (* xhi ylo) (* xlo yhi))
		     (max (* ylo xlo) (* yhi xhi))))
     ;; [-, +] & [-, -]
     ((and (is-negative xlo)
	   (is-positive xhi)
	   (is-negative ylo)
	   (is-negative yhi))
      (make-interval (* xhi ylo)
		     (* xlo ylo)))
     ;; [-, -] & [+, +]
     ((and (is-negative xlo)
	   (is-negative xhi)
	   (is-positive ylo)
	   (is-positive yhi))
      (make-interval (* xlo yhi)
		     (* xhi ylo)))
     ;; [-, -] & [-, +]
     ((and (is-negative xlo)
	   (is-negative xhi)
	   (is-negative ylo)
	   (is-positive yhi))
      (make-interval (* xlo yhi)
		     (* xlo ylo)))
     ;; [-, -] & [-, -]
     ((and (is-negative xlo)
	   (is-negative xhi)
	   (is-negative ylo)
	   (is-negative yhi))
      (make-interval (* xhi yhi)
		     (* xlo ylo))))))

;; Identify all possible cases & remember that when both are negative, high is closest
;; to 0 and when both positive low is closest to 0

;; (define a (make-interval 4 5))
;; (define b (make-interval 5 9))

;; (mul-interval a b)
;; => (20 . 45)
;; (mul-interval-case a b)
;; => (20 . 45)

;; (define c (make-interval -5 -4))
;; (define d (make-interval -5 67))

;; (mul-interval c d)
;; => (-335 . 25)
;; (mul-interval-case c d)
;; => (-335 . 25)
