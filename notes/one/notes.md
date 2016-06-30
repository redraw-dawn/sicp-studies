# 1 - Building Abstractions with Procedures

## 1.1 - Elements of Programming

Every language has 3 features:
- Primtive Expressions => the simplest entities the language is concerned with
- means of combination => compound elements are built from smaller ones
- means of abstraction => by which compound elements can be named and manipulated

In programming we deal with 2 elements:
- data => stuff to manipulate
- procedures => ways to manipulate it

an expression can be:
- 7 => a primitive expression
- (+ 2 2) => a compound expression
- potentially includes more than this

### 1.1.1 - Expressions

* Lisp expressions are contained within parentheses.
* Lisp follows prefix notation e.g. (+ 2 3) => operator first followed by operands

### 1.1.2 - Naming and the Environment

* to name a computational object use the special form "define" e.g. (define x 2) => x equals 2
* can use define to name compound expressions e.g. (define compound (* x (+ 10 2)))
* associating symbols and later retrieving them requires them to be stored in memory
* memory is aka environment. There can be a global environment; many programs will include multiple environments

### 1.1.3 - Evaluating Combinations

* To evaluate a combination the following must happen:
- evaluate subexpressions of the combination
- Apply the procedure (value of the leftmost expression/operator) to arguments that are the values of subexpressions
- this process is recursive

* Special forms are the only exception to the evaluation rule for the rest of Lisp.

### 1.1.4 - Compound Procedures

* Numbers and arithmetic operations are primitive data and procedures
* Nesting of combinations provides a means of combining operations

* To define a procedure we can use special form "define" again:
- general form is: (define (<name> <formal parameters>) (<body>))
- this can be used in a combination e.g. (+ (square 2) 8)

(define (square x) (* x x))
(define (sumOfSquares a b) (+ (square a) (square b)))

### 1.1.5 - The Substitution Model for Procedure Application

* compound procedures are evaluated in the same process as primitive procedures i.e. evaluates
  elements of combination then applies procedure (operand) to arguments (values of operators).
* Substitution model: evaluate the inner subexpressions by applying the operators one level at a time

#### Applicative Order VS Normal Order

(define (fn a) (sumOfSquares (+ a 1) (* a 2)))

* Normal Order:
- Substitute in operand expressions for parameters until an expression containing only primitive expressions is left
  and then evaluate

(f 5)
(sumOfSquares (+ 5 1) (* 5 2))
(+ (square (+ 5 1)) (square (* 5 2)) )
(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)) )
(+ (* 6 6) (* 10 10) )
(+ 36 100)
136

* Applicative Order:
- evaluate the arguments at each step of the substitution then apply operator

(f 5)
(sumOfSquares (+ 5 1) (* 5 2) )
(+ (square 6) (square 10) )
(+ (* 6 6) (* 10 10) )
(+ 36 100 )
136

* Lisp uses applicative-order evaluation for additional efficiency and for reduced complication in situations
  where the substitution model cannot be used.

### 1.1.6 - Conditional Expressions and Predicates

      / r if r > 0
|r| = | 0 if r = 0
      \ -r if r < 0

* this is called a case analysis and the special form in Lisp for this is "cond"

(define (abs x)
	(cond ((> x 0) x)
	((= x 0) 0)
	((< x 0) (-x))))

general form is:
(cond (<p1> <e1>)
      (<p2> <e2>)
      (<pn> <en>))

^ where p is a predicate and e is an expression
* a predicate is an expression which evaluates to true or false
* the predicates are evaluated in order and when one is found to be true the corresponding expression is evaluated

another way to write abs is:
(define (abs x)
	(cond (< x 0) (-x)
	(else x)))

* "else" is a special form that can be used in final place of a cond statement and always evaluates as true if all
  predicates fail

another way to write abs:
(define (abs x)
	(if (< x 0)
	(-x)
	x))

general form is:
(if <predicate> <consequent> <alternative>)

* if is a special form which is a restricted cond where there are two cases in the case analysis

* there are some logical composition operations which allow us to construct compound predicates, these are:
- (and <e1> ... <eN>) => all expressions are evaluated one by one and if all true it returns last expression
- (or <e1> ... <eN>) => evaluates one by one until one is true then returns that, unless all false then returns false
- (not <e1>) => evaluates to true when e1 is false and false otherwise

* note "and" and "or" are special expressions because not all subexpressions are always evaluated, "not" is normal.

examples:
- test x is greater than or equal to y:
  (define (>= x y)
  	  (or (> x y) (= x y)))
OR
  (define (>= x y)
  (not (< x y)))

### 1.1.7 Example: Square Roots by Newton's Method

* Procedures, like mathematical functions, return a value. However, they must be effective

e.g. square root function in maths can be defined as:
root x = the y such that y >= 0 and y^2 = x

* This defines a function but is not directly translatable to a procedure.
* The difference between function and a procedure is knowing the properties of something vs how to do it a.k.a
  declarative knowledge vs imperative knowledge

### 1.1.8 Procedures as Black-Box Abstractions

* A recursive procedure is one which calls itself
* It's important for procedures to accomplish an identifiable task
* When a procedure is used within another procedure it can be considered a procedural abstraction
* Parameters to procedures are local to procedures

i.e. (define (square x) (* x x)) & (define (addTwo x) (+ 2 x))
^ (square (addTwo 3)) => the "x" parameter of addTwo will not affect square's x

* Names of formal parameters are special in that they are arbitrary. The names are referred to as bound variables
* A procedure "binds" its formal parameters
* The meaning of a procedure is unchanged even if a bound variable is renamed throughout the definition
* Unbound variables are referred to as "free"

* The set of expressions for which binding defines a name is referred to as the "scope" of that name

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

* In good-enough? "guess" & "x" are bound variables and "<", "abs", "-" & "square" are free.
* Parameter names can override free variables and cause bugs.
* good-enough? is not independent of the free variables, it relies on them being defined elsewhere within scope

* In order to restrict scope of procedures it is possible to define them as subprocedures within a procedure to keep them scoped to the outer procedure only.
(define (sqrt x)
	(define (good-enough? guess x)
		(< (abs (- (square guess) x)) 0.001))
	(define (improve guess x)
		(average guess (/ x guess)))
	(define (sqrt-iter guess x)
		(if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x) x)))
	(sqrt-iter 1.0 x))

* This helps to minimise a cluttered namespace allows procedures to only be available where needed.

* Nesting procedures within other procedures is referred to as block structure

* Above, x is used in good-enough?, improve & sqrt-iter. Since it's bound by sqrt and all these are
  in the scope of that we can remove x from them as follows:

(define (sqrt x)
	(define (good-enough? guess)
		(< (abs (- (square guess) x)) 0.001))
	(define (improve guess)
		(average guess (/ x guess)))
	(define (sqrt-iter guess)
		(if (good-enough? guess)
		guess
		(sqrt-iter (improve guess))))
	(sqrt-iter 1.0)
	)

* block structure originated in the language Algol 60