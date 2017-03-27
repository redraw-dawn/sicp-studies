## Lecture 2

* Don't forget that recursion not only calls a method again, but adds a process to the procedure rather than starting from the top again.
* (fn arg0 arg1 arg2 etc) => how to call a function
* argument expressions are evaluated first to get argument values and then applied to function

* This is not the case in special forms; form == expression
  -> i.e. (define pi 3.1415)
  -> 'pi' is not evaluated before being applied to 'define'

* define out of parens is referred to as a keyword
* cond special form includes predicate tests grouped in parens with action expression.
  -> i.e. (cond
		((> x 0) x)
		(else -x))

* Applicative Order
1. Evaluate actual argument expressions
2. Call function with actual argument values

* Normal Order
1. Call functons w/ argument expressions
2. Evaluate argument expressions when performing primitive operations

* The two methods return the same value if code is written w/ the functional paradigm.

* Functional programming means if a function takes an argument it returns the same result every time
  -> i.e. (+ 2 1) always is 3

* Functional programming is much easier to parallelise due to order of evaluation not mattering
* random in scheme returns a non-negative value less than the argument provided
  -> i.e. (random 10) returns a number between 0 and 9
  