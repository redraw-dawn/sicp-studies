
# 1

## 1.1

Every language has 3 features:
- Primtive Expressions => the simplest entities the language is concerned with
- means of combination => compound elements are built from smaller ones
- means of abstraction => by which compound elements can be named and manipulated

In programming we deal with 2 elements:
- data => stuff to manipulate
- procedures => ways to manipulate it

### 1.1.1

* Lisp expressions are contained within parentheses.
* Lisp follows prefix notation e.g. (+ 2 3) => operator first followed by operands

### 1.1.2

* to name a computational object use the special form "define" e.g. (define x 2) => x equals 2
* can use define to name compound expressions e.g. (define compound (* x (+ 10 2)))
* associating symbols and later retrieving them requires them to be stored in memory
* memory is aka environment. There can be a global environment; many programs will include multiple environments

### 1.1.3

* To evaluate a combination the following must happen:
- evaluate subexpressions of the combination
- Apply the procedure (value of the leftmost expression/operator) to arguments that are the values of subexpressions
- this process is recursive

* Special forms are the only exception to the evaluation rule for the rest of Lisp.

### 1.1.4

* Numbers and arithmetic operations are primitive data and procedures
* Nesting of combinations provides a means of combining operations

* To define a procedure we can use special form "define" again:
- general form is: (define (<name> <formal parameters>) (<body>))
- (define (square x) (* x x)) => compound procedure named square that takes one argument
- this can be used in a combination e.g. (+ (square 2) 8) OR
- (define (sumOfSquares a b) (+ (square a) (square b)))






