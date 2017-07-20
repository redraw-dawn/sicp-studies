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

##### Counting Change example

* Write a method which returns the amount of ways that change can be made for an amount given a series of coin denominations
* Assuming the coins are arranged in an order the relation holds:
	- The number of ways to make change for amount a using n coins equals:
	1. Number of ways to make change for a using all but the first kind of coin
	2. The number of ways to make change from a - d using all n coins where d is the first coin
	3. Repeat this

* The ways to make change can be split into two groups, those that use the first coin and those that dont.
* Once steps 1 & 2 are completed once, you then have two branches with which to reapply that rule.
* The degenerate cases are:
1. if a == 0, we have 1 way to make change
2. if a < 0, we have 0 ways
3. if n == 0, we have 0 ways to make change

(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

* first-denomination takes an input to return the value of a coin to us (done in cents)
* This process generates a tree-recursive process with a large amount of redundancies similar to the fibonacci method
* The observation that a tree-recursive process is highly inefficient but easy to understand has lead people to
	get the best of both words by designing a smart compiler that optimised the procedure to be more efficient.

#### Iterative Change Counter

(define (count-change amount)
	(change-iter 1 5 0 100 100))

;; not properly changing the number coin for every iteration
(define (change-iter coin-num secondary-coin-num num-of-coins num-of-ways main-amount secondary-amount)
	(cond ((> coin-num num-of-coins) num-of-ways)
	      ((< main-amount 0) num-of-ways)
	      ((= secondary-amount 0) (CHANGE-ITER (+ NUM-OF-WAYS 1) (+ SECONDARY-COIN 1) ()))
	      ((= main-amount 0) (CHANGE-ITER (+ NUM-OF-WAYS 1)))
	      (else ((if (< secondary-amount 0)
	                 (CHANGE-ITER)
	                 (CHANGE-ITER))))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

### 1.2.3 Orders Of Growth

* 'n' is the parameter which measures the size of a problem, i.e.
  -> n could be the number of digits accuracy required on a calculation
  -> n could be number of rows in a matrix
* 'R(n)' represents the number of resources the process requires for a problem of size 'n', i.e.
  -> this could be the internal storage registers used
  -> this could be number of elementary machine operations
* The notion of an "order of growth" is used to obtain a gross measure of the resources required by a process as the input becomes larger
* There will often be a number of properties of a problem which will be useful to analyse a given process
* In computers that only do a fixed amount of operations at a time, the time required will be proportional
  to the number of elementary machine operations performed

### 1.2.4 Exponentiation

* b^n = b * b^(n-1) ... b^0 where b^0 = 1
* in scheme...

(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))

* Above is a linearly recursive iteration with theta(n) steps and space
* Below is an equivalent linear iterative approach which requires theta(n) steps and theta(1) space

(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                (- counter 1)
                (* b product))))

* Instead of computing b^8 as (b * (b * (b * (b * (b * (b * (b * b))))))) we can compute as:
b^2 = b * b
b^4 = b^2 * b^2
b^8 = b^4 * b^4

* This method works fine for exponents that are powers of 2. The following rule also applies:
b^n = ( b^(n/2) )^2 if n is even
b^n = b * b^(n-1)   if n is odd
in scheme...

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

;; N.B. remainder and modulo are primitive procedures functioning like %

* This process grows logarithmically with n in space and number of steps, as finding b^2n only requires 1 more multiplication.
  -> has theta(log n) growth

* Difference between theta(log n) and theta(n) grows large as n becomes larger,
  -> i.e. when n = 100, fast-expt only requires 14 steps instead of 1000

### 1.2.5 Greatest Common Divisors

* Euclid's Algorithm -> If `r is the remainder of `a divided by `b, then the common
  divisors of `a and `b are the same as of `b and `r, thus we can use:
  ```GCD(a, b) = GCD(b, r)```
  to reduce problem to smaller integers.

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

* Steps grow as the logarithm of numbers involved (do more research into algorithms
  to get a better grasp on this)

* Lamé's theorem: if Euclid's Algorithm requires `k steps to compute the GCD of some
  pair than the smaller number in the pair must be >= to `k-th Fibonacci number

* Using above we can see that the order of growth...
* if process takes `k steps then we have: n >= Fib(k) ~ theta^(`k)/sqrt(5)
* therefore number of steps `k grows as logarithm of n hence = theta(log n)

### 1.2.6 Testing for Primality

#### Searching for Divisors

* One way to test is to check divisibility by successive integers

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

* The end test is that if n has a divisor it must be less than sqrt(n) therefore steps will have order of growth of theta(sqrt(n))

#### The Fermat Test

* Fermat's theorem: if `n is a prime number and `a is any positive integer less than `n, then `a raised to the `nth power is congruent to `a modulo `n, or `a
* Congruent modulo means two numbers have the same remainder when divided by `n
* If `n is not prime than most numbers will not satisfy this relation.
* To increase confidence in this algorithm it needs to be tested multiple times

* We need for this a procedure that calculates an exponential of a number module another number

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

* The above procedure uses successive squaring so the number of steps grows at theta(log n)
* The random number is generated by primitive method random in scheme which takes an int as arg and returns a number less than that
  -> i.e. (random 4) returns a number between 1 and 4

* to get a number between 1 and `n - 1 we call (+ 1 (random (- n 1)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

* The following tests a specific number of times

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

#### Probablistic Methods

* Fermat theorem is not guaranteed, it indicates a strong likelihood
* There are rare exceptions to the Fermat test
* One can prove that Fermat theorem does not hold for most integers `a<`n unless it is prime
* If it passes the test a number of times we can reduce the probability of error
* If it fails the test we can be certain it is not prime

* The existence of tests for which one can prove the error to be arbitrarily small is known as probablistic algorithms