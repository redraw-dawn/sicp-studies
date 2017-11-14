## 2.2 - Hierarchical Data and the Closure Property

- Pairs are created with `cons`
- Pairs can be made of other pairs
- The book uses box and pointer notation
- A box for a number contains a numeral.
- A box for a pair is a double box which contains a pointer to `car` and a pointer to `cdr`
- "Closure Property" -> an operation for combining things satisfies the closure property if the result of the combining
  can be combined using the same operation
- We can make hierarchical structures using property

### 2.2.1 - Representing Sequences

- To build a sequence 1 through 4 do
  (cons 1 (cons 2 (cons 3 (cons 4 '()))))
- End a list with '(). Textbook uses `nil` but my repl doesn't accept that.
- Alternatively, can do (list 1 2 3 4)
- `(car (list 1 2 3 4))` selects the head of the list -> 1
- `(cdr (list 1 2 3 4))` selects tail of list -> (2 3 4)

#### List Operations

- The use of pairs to represent lists allows us to `cdr` down the list
- The following example finds the nth element of a list:

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))

(list-ref squares 3)
=> 16

- Scheme provides `null?` to test if a list is empty

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define odds (list 1 3 5 7))

(length odds)
=> 4

- The above method is recursive and the below method is iterative/tail recursive

(define (length items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

- Another convention is to "cons up" a list whilst "cdr-ing down" as in append which appends list1 onto list2

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

- To give a procedure an arbitrary amount of args (such as in +, * or list), scheme uses dotted-tail notation
- This is done by putting a dot (.) before the last argument, i.e.

(define (f a b . c)
	;; do stuff
	)

- c will be a list of arguments. N.B. can pass no args; this returns an empty list