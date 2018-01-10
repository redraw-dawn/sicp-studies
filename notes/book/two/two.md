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

- `c` will be a list of arguments. N.B. can pass no args; this returns an empty list

#### Mapping Over Lists

- mapping is applying the same transformation to each element in a list and generating the list of results
- `map` is a higher-order procedure which takes a procedure of one argument and a list and returns a list of results by applying the procedure to each element of the list

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

- `map` is important because it acts as an abstraction barrier between the procedures that transform lists and the procedures that extract and combine elements of the list so we could in theory change how sequences are implemented without affecting higher-level concepts

### 2.2.2 Hierarchical Structures

- Sequences made up of sequences can be thought of to be structured as trees
- Operations on tree structures are a natural fit for recursion as they can be reduced to operations on their branches

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

- Scheme has the primitive `pair?` which tests if the argument is a pair or not

#### Mapping Over Trees

- To map over a tree, regard it as a list of subtrees

### 2.2.3 Sequences as Conventional Interfaces

- Conventional interfaces are a design principle for working with data structures

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

- A common pattern (referred to as signals) can be derived from these two procedures:

* Enumerate through collection
* Filter collection
* Map collection (filter + map = `collect` in scala)
* Accumulate the results

- the higher order function map is referred to as a transducer -> changes state
- These two procedures do not implement the signal flow structure shown in book
  in an isolated manner so cannot be refactored in their current form.
- Their enumeration, filtering & accumulation is done in multiple locations

#### Sequence Operations

- filter operation on list can be defined as:

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

- accumation defined as:

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

- enumerate (generate sequence of elements to be processed) intervals:

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

- enumerate a tree (same as fringe procedure done in ex2.28):

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

- Now we can refactor sum-odd-squares and even-fibs as in the signal diagrams.
- sum-odd-squares we enumerate leaves of tree, filter the odd ones, square each
  element and sum

(define (sum-odd-squares tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))

- even-fibs enumerates integers, generates fibonacci sequence for them, filters
  to keep only even elements, accumulates result

(define (even-fibs n)
  (accumulate cons
              nil
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

- Expressing programs as sequence operations allows one to design programs that
  are modular (constructed by relatively independent pieces).
- Modular design can be encouraged by providing standard library of components
  and interface for connecting/operating on the components

- Sequences (lists) serve as a interface that allow us to combine processing
  modules.

- When all structures are represented as sequences the data-structure specific
  code is limited to a minimal amount of operations.

- This allows us to modify the representations of sequences whilst leaving programs
  in tact.