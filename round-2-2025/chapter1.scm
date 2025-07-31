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
