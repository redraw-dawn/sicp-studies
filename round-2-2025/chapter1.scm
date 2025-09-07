(define size 2)

(define (square x)
  (* x x))

(+ 3 4 size (square size))

(define (sum-of-squares x y)
  (+ (square x) (square y)))


(+ 42 (sum-of-squares 3 4))


(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))
        (else 69)))

(define (abs-2 x)
  (cond ((< x 0) (- x))
        (else x)))

(define (abs-3 x)
  (if (< x 0)
      (- x)
      x))

(abs-3 -79)

(define one-point-two
  (/
   (+ 5 4
      (- 2
         (- 3
            (+ 6
               (/ 4 5)
               )
            )
         )
      )
     (* 3
        (- 6 2)
        (- 2 7)
        )
     )
  )


(+ 0 size one-point-two)

one-point-two

(+ one-point-two 22)

(+ one-point-two 2)

(define (one-point-three a b c)
  (cond ((and (> a b) (> b c)) (+ (square a) (square b)))
        ((and (> a c) (> c b)) (+ (square a) (square c)))
        (else (+ (square b) (square c)))))

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(+ 4 8)

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

;; (define (sqrt-iter-2 guess x)
;;   (gen-iter guess x improve good-enough? 0))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-2 x)
  (sqrt-iter-2 1.0 x))

;; 1.6
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; doesn't have delayed evaluation from special-clause, if
;; therefore the else-clause always gets evaluated resulting
;; in never-ending calls to sqrt-iter ^

;; 1.7
(define (new-good-enough? guess last x)
  (< (abs (- (square guess) last)) (* 0.01 x)))

;; 1.8
(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
  (gen-iter (improve-cube x guess) guess x improve-cube good-enough-cube?))

(define (gen-iter guess last-guess x root-fn good-enough-fn)
  (display guess)
  (newline)
  (if (good-enough-fn guess last-guess x)
      guess
      (gen-iter (root-fn x guess) guess x root-fn good-enough-fn)))

(define (display-n n)
  (display n)
  (newline)
  n)

(define (improve-cube x y)
  (/
   (+ (/ x (* y y))
      (* 2 y))
   3.0))

(define (good-enough-cube? guess last-guess x)
  ;; (< (abs (- (cube guess) x)) 0.01))
  (< (abs (- guess last-guess)) (* 0.001 x)))

(define (cube x)
  (* x x x))
