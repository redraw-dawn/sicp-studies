# Lecture 2
substitution model:
- evaluate operator to get procedure
- evaluate operand to get arguments (args passed to as formal parameters)
- apply procedure to arguments
  -> copy body of procedure with args supplied for parameters
- evaluate new body

kinds of expressions:
- numbers
- symbols
- lambda expressions
- definitions
- conditionals
- combinations -> this is what we're evaluationg

if <predicate> is true evaluate <consequent>, else evaluate <alternative>
if statement:
(if <predicate>
    <consequent>
    <alternative>)

- tail recursion/iteration evaluated with substitution model is:
 -> time: O(x)
 -> space: O(1)

- linear recursion evaluated with substitution model is:
 -> time: O(x)
 -> space: O(x)

recursive procedure != recursive process

iteration has all of its state in explicit variables

(define (fib x)
	(if (< x 2)
	    x
	    (+ (fib (- x 1))
	       (fib (- x 2)))))

time: O(fib(x))
space: O(n)

#### towers of hanoi
(define (move n from to)
	(cond ((= n o) "DONE")
	      (else
		(move (-1 n) from spare to))))
write an iterative algorith to solve towers of hanoi & a fibonacci generator