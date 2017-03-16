(define fib-iter
  (lambda (previous current n)
    (cond
     ((= 0 n) 0)
     ((= 1 n) 1)
     ((<= n 2) current)
     (else
      (fib-iter current (+ current previous) (- n 1))))))

(define fibonacci
  (lambda (n)
    (fib-iter 0 1 n)))

;; towers of hanoi with tail recursion... gg
