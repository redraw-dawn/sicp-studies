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

### 1.2.2 - Tree Recursion

Defining the fibonnaci process as below creates what is known as tree recursion due to the pattern of evaluation (figure 1.5).

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

To compute (fib 5) you must compute (fib 4) && (fib 3) and so on. Thus creating a tree like structure with "leaves". 
This is a poor way to compute Fibonacci numbers because it duplicates a lot of computations (i.e. has to work out (fib 3) twice)

* The number of leaves in the tree can be shown to be (fib (+ n 1)). 
* Thus the process uses a number of steps thats grows exponentially with the input `n`.
* The space required grows only linearly as we need only keep track of the node above us at any point in computation
* In general, the number of steps required by a tree-recursive process will be proportional to number of nodes in tree && space will be proportional to max depth of the tree

* It's possible to create an iterative process using a pair of integers (a & b) and a counter.
* each time the process iterates, a will become (+ a b) and b will become original value of a
* after applying this n times, a and b will to (fib (n + 1)) and (fib n) respectively.

(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

* This method is a linear iteration.
* The difference in steps between the two methods is one grows at (fib n) and one linear to n
* Tree recursion can be a powerful tool to operate on hierarchically structures data (as opposed to numbers)
* Although the tree-recursive process is inferior performance wise, it can be useful in helping us to understand and design programs
* i.e. the tree-recursion method for fibonacci is a direct translation of the method but the iterative process required us to notice it could be done with three state variables.



