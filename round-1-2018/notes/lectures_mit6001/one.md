# Lecture 1

processes are what goes on in a computer
procedures are the instructions of a process

## blackbox abstraction
(+ 3 17.4 5) <- this is a combination
numbers are primitive and so is +
+ is operator and numbers are operands.
combinations can contain combinations.
combination is evaluated by applying operands to operator.
Lisp uses prefix notation.
combinations can be represented as a tree

combination:
(define (square x) (* x x))
can be more clearly represented as:
(define square (lambda (x) (* x x)))
'block structure' -> packaging internals inside a definition