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
