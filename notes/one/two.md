## 1.2  - Procedures and the Processes They Generate

* A procedure is a pattern for the local evolution of a computational process.
* This chapter will deal with making analysing the global behavior of these procedures.

### 1.2.1 - Linear Recursion and Iteration

To work out n!, times n by (n - 1)

(define (factorial n)
	(if (= n 1)
	1
	(* n (factorial (- n 1)))))

* This calls factorial n times until n = 1 then it evaluates

i.e.
(factorial 3)
(* 3 (factorial 2))
(* 3 (* 2 (factorial 1)))
(* 3 (* 2 1))
(* 3 2)
6

^ This is linear

* To compute this in an iterative manner we will maintain a running product, a counter and n
* This will follow the rule that each iteration the counter will check to see if it is > n. if not product will be multipled by the counter and the counter will be incremented by one

(define (factorial n)
	(fact-iter 1 1 n))

(define (fact-iter product counter max-count)
	(if (> counter max-count)
	product
	(fact-iter (* product counter)
		   (+ counter 1)
		   	max-count)))

i.e.
(factorial 3)
(fact-iter  1 1 3)
(fact-iter 1 2 3)
(fact-iter 2 3 3)
(fact-iter 6 4 3)
6

* Both methods grow in steps as n increases but the "shape" of each the processes is quite different

* The first substitution model reveals expansion then contraction. This occurs as the process builds a chain of "deferred operations"
* The contractions occur as the these are performed
* This is referred to as a recursive process
* This process requires the interpreter to keep track of the operations to be later performed.
* As the number of steps increases with n in this example, it is called a "liner recursive process"

* The second process only requires us to keep track of the current values of the variables product, counter and max-count
* This is called an "iterative process"
* In general, an iterative process is one that can be summarized by:
- A fixed number of state variables
- A rule which describes how the state variables should be updated as the process continues
- OPTIONAL an end test for the process to terminate on
* In computing n! the steps grow linearly with n, this means this is a "linear iterative process"

* In the iterative process, the program variables provide a complete description of the state at any point.
* In the recursive process, there is some 'hidden' information maintained in the interpreter which indicates where it is up to in negotiating the chain of deferred operations
* The longer the chain, the more information must be maintained (memory used)

* Do not confuse a recursive process with a recursive procedure. Differences are:
- If a procedure is recursive, it refers to itself in the definiton
- If we describe a process as linearly recursive we are referring to how it evolves
* i.e. fact-iter is a recursive procedure but it generates an iterative process.

* Common languages, including C, are designed in a way that the interpretation of a recursive procedure consumes an amount of memory that increases with procedure call regardless that it may be iterative.
* As a consequence, these languages describe iterative processes with looping constructs i.e. while, until, for.
* Scheme does not share this defect and will execute an iterative process in constant space even if it is in a recursive procedure.
* This is referred to as tail-recursion. With this iteration does not require a special looping construct unless for syntactic sugar.