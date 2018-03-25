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
(define (div-interval x y)
  (if (or (= (lower-bound x) (upper-bound x)) (= (lower-bound y) (upper-bound y)))
      (error "Cannot divide interval that spans 0")
      (mul-interval x
		    (make-interval (/ 1.0 (upper-bound y))
				   (/ 1.0 (lower-bound y))))))

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

;; Exercise 2.12
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;; Define make-center-percent which constructs interval from centre and percentage of error
;; where percent is the ratio of the width of the interval to the center
;; Define selector 'percent' which calculates the uncertainty from the interval

(define (make-center-percent center percent)
  (let ((width (* center (/ percent 100))))
    (make-center-width center width)))

(define (percent interval)
  (abs (* 100 (/ (* (width interval) 1.0) (center interval)))))

;; Exercise 2.13
;; Approximate percentage tolerance of product of two intervals in terms of tolerance of factors

;; TESTING:
;; (define a (make-center-percent 8 0.15))
;; (define b (make-center-percent 10 0.10))
;; (define c (make-center-percent 100 0.07))
;; (define d (make-center-percent 120 0.05))

;; (percent (mul-interval a b))
;; => .24630541871921183

;; (percent (mul-interval c d))
;; => .11958146487294469

;; therefore, for low tolerance intervals, tolerance of product can be approximated as the sum of the
;; factors' tolerances
(define (approx-tolerance-of-product a b)
  (+ (percent a) (percent b)))

;; Exercise 2.14
;; Demonstrate that these two algebraically equivalent functions return different results
;; Investigate system's arithmetic functions
;; Make intervals a & b; and compute a/a and a/b

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; (define a (make-center-percent 100 5))
;; (define b (make-center-percent 100 8))

;; (par1 a b)
;; => (41.032863849765256 . 60.64171122994652)

;; (par2 a b)
;; => (46.73796791443851 . 53.23943661971831)

;; (define aa (div-interval a a))
;; => (.9047619047619049 . 1.1052631578947367)
;; N.B. -> Does not equal 1

;; (define ab (div-interval a b))
;; => (.8796296296296295 . 1.141304347826087)

;; Exercise 2.15
;; Eva Lu Ator is right. Dividing an interval by itself does not equal 1. par1 is therefore not algebraically
;; equivalent to par2. Using intervals multiple times isn't guaranteed to return the same values.

;; Exercise 2.16
;; An interval divided by itself does not equal 1.

;; Exercise 2.17
;; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list
;; (last-pair (list 23 72 149 34))
;; => (34)
(define (last-pair ls)
  (if (null? (cdr ls))
      ls
      (last-pair (cdr ls))))

;; Exercise 2.18
;; Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse order:
;; (reverse (list 1 4 9 16 25))
;; => (25 16 9 4 1)

(define (reverse ls)
  (define (loop lst acc)
    (if (null? lst)
	acc
	(loop (cdr lst) (cons (car lst) acc))))
  (loop ls '()))

;; from example
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse ls)
  (if (null? ls)
      ls
      (append (reverse (cdr ls)) (list (car ls)))))

;; Exercise 2.19
;; Define no-more?, first-denomination and except-first-denomination
;; Does the order of the list affect the answer produced by cc? Why or why not?
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define no-more? null?)
(define first-denomination car)
(define except-first-denomination cdr)

;; (cc 100 us-coins)
;; => 292

;; (cc 100 (reverse us-coins))
;; => 292

;; Order does not affect the answer because the same nodes on the tree are generated
;; regardless.

;; Exercise 2.20
;; Write same-partity that takes a list of numbers and returns even/odd depending on
;; the first arguments even/odd parity
(define (even? n)
  (= 0 (modulo n 2)))

(define (odd? n)
  (not (even? n)))

(define (filter f ls)
  (cond
   ((null? ls) '())
   ((f (car ls))
    (cons (car ls) (filter f (cdr ls))))
   (else
    (filter f (cdr ls)))))

(define (same-parity l . ls)
  (let ((f (if (even? l)
	       even?
	       odd?)))
    (cons l (filter f ls))))


;; Ex 2.21
;; Fill in the gaps of square-list
(define (square x)
  (* x x))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list (cdr items)))))

(define (square-list items)
  (map square items))

;; Exercise 2.22
;; Explain why this gives reverse
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

;; And explain why this doesn't work
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

;; 1 - The list is built by appending the first item onto the empty list, then the second onto the first, etc
;; 2 - The base of the list must be a nil/'() otherwise it will build a pair

;; Exercise 2.23
;; for-each is like map except the no value is returned Define for-each
(define (for-each ls fn)
  (if (null? ls)
      #t
      (begin
	(fn (car ls))
	(for-each (cdr ls) fn))))

;; Exercise 2.24
;; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). Give the result
;; printed by the interpreter, the corresponding box-and-pointer structure, and the
;; interpretation of this as a tree (as in figure 2.6).

;; (1 (2 (3 4)))
;; I've done the box and pointer and tree structure drawings on paper. You'll have to trust that.

;; Exercise 2.25
;; Give combinations of cars and cdrs that will pick 7 from each of the following lists:

(define one (list 1 3 (list 5 7) 9))
(car (cdr (car (cdr (cdr one)))))

(define two (list (list 7)))
(car (car two))

;; (1 (2 (3 (4 (5 (6 7))))))
(define three (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr three))))))))))))

;; Exercise 2.26
(define x (list 1 2 3))
(define y (list 4 5 6))

;; What are the printed results of:
;; (append x y)
(1 2 3 4 5 6)

;; (cons x y)
((1 2 3) 3 4 5)

;; (list x y)
((1 2 3) (4 5 6))

;; Exercise 2.27
;; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse procedure
;; that takes a list as argument and returns as its value the list with its elements
;; reversed and with all sublists deep-reversed as well.
(define (deep-reverse ls)
  (cond ((null? ls)
	 ls)
	((and (pair? (car ls)) (null? (cdr ls)))
	 (list (deep-reverse (car ls))))
	((pair? (car ls))
	 (append (deep-reverse (cdr ls)) (list (deep-reverse (car ls)))))
	(else
	 (append (deep-reverse (cdr ls)) (list (car ls))))))

;; Exercise 2.28
;; Write a procedure fringe that takes as argument a tree (represented as a list)
;; and returns a list whose elements are all the leaves of the tree arranged in
;; left-to-right order.

(define (fringe ls)
  (cond
   ((null? ls) ls)
   ((pair? (car ls))
    (append (fringe (car ls)) (fringe (cdr ls))))
   (else
    (cons (car ls) (fringe (cdr ls))))))

;; Exercise 2.29
;; A binary mobile consists of two branches, a left branch and a right branch.
;; Each branch is a rod of a certain length, from which hangs either a weight or
;; another binary mobile. We can represent a binary mobile using compound data by
;; constructing it from two branches

(define (make-mobile left right)
  (list left right))

;; A branch is constructed from a length (which must be a number) together with a
;; structure, which may be either a number (representing a simple weight) or another mobile

(define (make-branch length structure)
  (list length structure))

;; a. Write the corresponding selectors left-branch and right-branch, which return
;; the branches of a mobile, and branch-length and branch-structure, which return
;; the components of a branch.

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

;; Structure is either the weight (number) or a mobile -> Either[Weight, Mobile]
(define (branch-structure branch)
  (car (cdr branch)))

;; b. Using your selectors, define a procedure total-weight that returns the total
;; weight of a mobile.

(define (total-weight mobile)
  (add-branches mobile))

(define (add-branches mobile)
  (+ (handle-branch (left-branch mobile))
     (handle-branch (right-branch mobile))))

(define (handle-branch branch)
  (let ((structure (branch-structure branch)))
    (if (pair? structure)
	(add-branches structure)
	structure)))

;; c. A mobile is said to be balanced if the torque applied by its top-left branch is
;; equal to that applied by its top-right branch (that is, if the length of the left
;; rod multiplied by the weight hanging from that rod is equal to the corresponding
;; product for the right side) and if each of the submobiles hanging off its branches
;; is balanced. Design a predicate that tests whether a binary mobile is balanced.

(define (balanced? mobile)
  (let ((left (left-branch mobile))
	(right (right-branch mobile)))
    (and (= (branch-torque left)
	    (branch-torque right))
	 (balanced-branch? left)
	 (balanced-branch? right))))

(define (branch-torque branch)
  (* (handle-branch branch)
     (branch-length branch)))

;; At every level check torque and if structure is a mobile check the next level down
(define (balanced-branch? branch)
  (let ((structure (branch-structure branch)))
    (if (pair? structure)
	(balanced? structure)
	#t)))

;; must be true (balanced)
(define a (make-mobile (make-branch 3 9) (make-branch 2 13.5)))
(balanced? a)
;; Value: #t

;; must be false
(define b (make-mobile (make-branch 2 8) (make-branch)))
(balanced? b)
;; Value: #f

(define c (make-mobile (make-branch 2 a) (make-branch 2 a)))
(balanced? c)
;; Value: #t

;; d. Change constructors and see how much of the programs need to change to
;; accommodate new structure

(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))


;; Exercise 2.30
;; Define square-tree both directly (i.e., without using any higher-order procedures)
;; and also by using map and recursion.

(define (square-tree tree)
  (cond
   ((null? tree) '())
   ((pair? (car tree))
    (cons (square-tree (car tree))
	  (square-tree (cdr tree))))
   (else
    (cons (* (square (car tree)))
	  (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (subtree)
	 (if (pair? subtree)
	     (square-tree-map subtree)
	     (square subtree)))
       tree))


;; Exercise 2.31.
;; Abstract your answer to exercise 2.30 to produce a procedure tree-map with the
;; property that square-tree could be defined as:

(define (square-tree tree)
  (tree-map square tree))

(define (tree-map fn tree)
  (map (lambda (subtree)
	 (if (pair? subtree)
	     (tree-map fn subtree)
	     (fn subtree)))
       tree))

;; Exercise 2.32
;; Complete the following definition of a procedure that generates the set of subsets
;; of a set and give a clear explanation of why it works.
;; must return => (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
(define nil '())

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
			    (cons (car s) x))
			  rest)))))

;; Every level of recursion, the head of the list is appended to every combination
;; list of the tail.

;; (1 2 3) -> 1 (2 3)
;; (2 3)   -> 2 (3)
;; (3)     -> 3 ()
;; ()


;; Exercise 2.33
;; Fill in the missing expressions to complete the following definitions of some
;; basic list-manipulation operations as accumulations:

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;; Exercise 2.34
;; Write missing lambda for Horner's rule method

;; Notes:
;; 1
;; x(1) + 0
;; x(x(1) + 0) + 5
;; x(x(x(1) + 0) + 5) + 0
;; x(x(x(x(1) + 0) + 5) + 0) + 3
;; x(x(x(x(x(1) + 0) + 5) + 0) + 3) + 1

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
		(+ (* x higher-terms) this-coeff))
              0
              coefficient-sequence))

;; Exercise 2.35
;; Redefine count-leaves from section 2.2.2 as an accumulation:

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))

;; Exercise 2.36
;; Fill in the missing expressions of accumulate-n
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init <??>)
            (accumulate-n op init <??>))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

;; Exercise 2.37
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;; Fill in missing definitions
(define (matrix-*-vector m v)
  (map <??> m))

(define (matrix-*-vector m v)
  (map (lambda (r) (dot-product r v)) m))

(define (transpose mat)
  (accumulate-n <??> <??> mat))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map <??> m)))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (r) (matrix-*-vector cols r)) m)))

;; Exercise 2.38
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (accumulate op initial sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; what are values of following:
(fold-right / 1 (list 1 2 3))
;; => 3/2
(fold-left / 1 (list 1 2 3))
;; => 1/6
(fold-right list nil (list 1 2 3))
;; => (1 (2 (3 ())))
(fold-left list nil (list 1 2 3))
;; => (((() 1) 2) 3)

;; Give a property that op should satisfy to guarantee that fold-right and
;; fold-left will produce the same values for any sequence.
;; Associativity (encountered in FP)

;; Ex 2.39
;; Complete the following lambdas of reverse (exercise 2.18) in terms of
;; fold-right and fold-left from exercise 2.38:
(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (reverse sequence)
  (fold-left (lambda (y x) (cons x y)) nil sequence))

;; Ex 2.40
;; 1. Define procedure unique-pairs
;; 2. Use unique-pairs to simplify prime-sum-pairs from notes

(define (unique-pairs n)
  (accumulate append '()
	      (map (lambda (i)
		     (map (lambda (j)
			    (list i j))
			  (enumerate-interval 1 (- i 1))))
		   (enumerate-interval 1 n))))

(define (enumerate-interval x y)
  (if (or (< x y) (= x  y))
      (cons x (enumerate-interval (+ x 1) y))
      '()))

(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum? (unique-pairs n))))

;; Ex 2.41
;; Write a procedure to find all ordered triples of distinct positive integers
;; i, j, and k less than or equal to a given integer n that sum to a given
;; integer s.

;; Need to add an extra level of nesting from previous
;; instead of filtering for prime sum, filter for (= sum s)

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (make-triples limit)
  (flatmap (lambda (k)
	 (flatmap (lambda (i)
		(map (lambda (j)
		       (list k i j))
		     (enumerate-interval 1 (- i 1))))
	      	 (enumerate-interval 1 (- k 1))))
       (enumerate-interval 1 limit)))

(define (triple-sum-equals n triple)
  (let ((sum (accumulate + 0 triple)))
    (= n sum)))

(define (triple-sum-equals n)
  (lambda (triple)
    (let ((sum (accumulate + 0 triple)))
      (= n sum))))

(define (filter f ls)
  (cond
   ((null? ls) '())
   ((f (car ls))
    (cons (car ls) (filter f (cdr ls))))
   (else
    (filter f (cdr ls)))))

(define (triples-under-limit-that-sum-to-s limit s)
  (filter (triple-sum-equals s) (make-triples limit)))

;; Exercise 2.42
;; implement: adjoin-position, empty-board & safe?
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board) ;; return empty to finish function
        (filter
         (lambda (positions) (safe? k positions)) ;; filter (list col row) to see if queen is safe
         (flatmap
          (lambda (rest-of-queens) ;; recursion of (queens-cols k)
            (map
	     (lambda (new-row)
	       (adjoin-position new-row k rest-of-queens)) ;; join position with of rest of positions. cons or append?
	     (enumerate-interval 1 board-size))) ;; create list of int the length of the board
          (queen-cols (- k 1))))))
  (queen-cols board-size))

;; Position represented as: (list col row)
(define (adjoin-position row col rest-of-queens)
  (cons (list col row) rest-of-queens))
(define empty-board '())
(define (safe? column positions)
  (and (row-safe? positions)
       (col-safe? positions)
       (diagonal-safe? positions)))

(define row-safe?
  (is-safe? get-row))

(define col-safe?
  (is-safe? get-col))

(define (is-safe? get-value)
  (lambda (positions)
    (define (duplicate value)
      (lambda (position)
	(= value (get-value position))))
    (define (checkrows remaining past)
      (cond
       ((null? remaining) #t)
       ((exists (duplicate (get-value (car remaining))) past) #f)
       (else
	(checkrows (cdr remaining) (cons (car remaining) past)))))
    (checkrows positions '())))

(define (diagonal-safe? positions)
  (define (diagonal-check up low remaining)
    (cond
     ((null? remaining) #t)
     ((or (= (get-row (car remaining)) up) (= (get-row (car remaining)) low)) #f)
     (else
      (diagonal-check (inc up) (dec low) (cdr remaining)))))
  (if (null? positions)
      #t
      (diagonal-check (inc (get-row (car positions)))
		      (dec (get-row (car positions)))
		      (cdr positions))))

(define (dec n) (- n 1))
(define (inc n) (+ n 1))

(define (get-row position)
  (cadr position))

(define (get-col position)
  (car position))

(define (exists predicate ls)
  (cond
   ((null? ls) #f)
   ((predicate (car ls)) #t)
   (else
    (exists predicate (cdr ls)))))

;; Exercise 2.43
;; Explain why the following version of queens-cols is slower
(flatmap
 (lambda (new-row)
   (map
    (lambda (rest-of-queens)
      (adjoin-position new-row k rest-of-queens))
    (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

;; This version of queens-cols is slower because a new queens-cols procedure is
;; evaluated for each enumeration rather than running through the enumeration
;; within each queens-cols. This turns a linear recursive method into a tree
;; recursive method

;; Exercise 2.44
;; Define up-split, like right-split but switches roles of below and beside
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (upsplit painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
	(below painter (beside smaller smaller)))))

;; Exercise 2.45
;; define splitting operation that covers right-split and up-split
(define (split fn fn2)
  (lambda (painter n)
    (if (= n 0)
	painter
	(let ((smaller (split painter (- n 1))))
	  (fn painter (fn2 smaller smaller))))))

;; Exercise 2.46
;; Add data abstraction for vectors & some selectors. Then implement procedures
;; add-vect, sub-vect and scale-vect
(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (modify-vect op)
  (lambda (v1 v2)
    (let ((x (op (xcor-vect v1) (xcor-vect v2)))
	  (y (op (ycor-vect v1) (ycor-vect v2))))
      (make-vect x y))))

(define (add-vect v1 v2)
  ((modify-vect +) v1 v2))

(define (sub-vect v1 v2)
  ((modify-vect -) v1 v2))

(define (scale-vect scale vect)
  (make-vect
   (* scale (xcor-vect vect))
   (* scale (ycor-vect vect))))

;; Exercise 2.47
;; make selectors for frame constructors
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr fp))

(define (edge2-frame frame)
  (cddr fp))

;; Exercise 2.48
;; Make constructor for segment and selectors for start and end
(define (make-segment vect1 vect2)
  (cons vect1 vect2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;; Exercise 2.49
;; Using segments->painter, answer the following:
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;; draw-line draws a line between two points

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;; a) a painter that draws the outline of the designated frame
(define outline
  (define outline-segments
    (list
     (make-segment (make-vect 0 0) (make-vect 0 1))
     (make-segment (make-vect 0 1) (make-vect 1 1))
     (make-segment (make-vect 1 1) (make-vect 1 0))
     (make-segment (make-vect 1 0) (make-vect 0 0))))
  (segments->painter outline-segments))
;; b) a painter that draws an 'X' by connecting opposite corners of frame
(define x
  (define x-segments
    (list
     (make-segment (make-vect 0 0) (make-vect 1 1))
     (make-segment (make-vect 0 1) (make-vect 1 0))))
  (segments->painter x-segments))
;; c) a painter that draws a diamond shape by connecting midpoints of sides frame
(define diamond
  (define diamond-segments
    (list
     (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
     (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
     (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
     (make-segment (make-vect 0.5 0) (make-vect 0 0.5))))
  (segments->painter diamond-segments))
;; d) the wave painter
;; nup

;; Ex2.50 define flip-horiz, rotate-by-180 & rotate-by-270
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (flip-horiz painter)
  (transform-painter painter
		     (make-vect 1 0)
		     (make-vect 0 0)
		     (make-vect 1 1)))

;; same as flip-vert in book?
(define (rotate-180 painter)
  (transform-painter painter
		     (make-vect 1 1)
		     (make-vect 0 1)
		     (make-vect 1 0)))

(define (rotate-270 painter)
  (transform-painter painter
		     (make-vect 1 0)
		     (make-vect 0 0)
		     (make-vect 1 1)))

;; Exercise 2.51
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

;; Define below like beside
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-top
	   (transform-painter painter1
			      (make-vect 0.0 0.0)
			      (make-vect 1.0 0.0)
			      split-point))
	  (paint-bottom
	   (transform-painter painter2
			      split-point
			      (make-vect 1.0 0.5)
			      (make-vect 0.0 1.0))))
      (lambda (frame)
	(paint-top frame)
	(paint-right frame)))))

;; Define below using beside & rotation i.e. ex 2.50
(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (below painter1 painter2)
  (rotate90 (beside (rotate-270 painter1) (rotate-270 painter2))))


;; Ex 2.52
;; a) Low level
;; Change at lowest level is changing segments/coords

;; b) Mid level
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left up)
              (bottom-right right)
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

;; c) High level
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  flip-horiz identity)))
    (combine4 (corner-split painter n))))

;; Ex 2.53
;; What would interpreter print for the following:

(list 'a 'b 'c)
;; => (a b c)
(list (list 'george))
;; => ((george))
(cdr '((x1 x2) (y1 y2)))
;; => ((y1 y2))
(cadr '((x1 x2) (y1 y2)))
;; => (y1 y2)
(pair? (car '(a short list)))
;; => #f
(memq 'red '((red shoes) (blue socks)))
;; => #f
(memq 'red '(red shoes blue socks))
;; => (red shoes blue socks)

;; Ex 2.54
;; Define equal. if list, they must contain same elements in same order. Otherwise
;; use eq? for symbol equality.
(define (equal? a b)
  (cond
   ((and (null? a) (null? b)) #t)
   ((and (pair? a) (pair? b))
    (if (eq? (car a) (car b))
	(equal? (cdr a) (cdr b))
	#f))
   ((or (null? a) (null? b)) #f)
   ((or (pair? a) (pair? b)) #f)
   (else (eq? a b))))

;; Ex 2.55
;; quote is returned as 'x is shorthand for (quote x) so the expression evaluates
;; to (quote (quote abracadabra))
