# 2 - Building Abstractions with Data

### Introduction

- Will look into more complex data structures than the primitives of chapter 1
- Will build abstractions by combining data objects to form "compound data"
- Compound data provides the same benefits of compound procedures:

  - Elevate conceptual level at which we design programs
  - Increase modularity of design
  - Enhance expressive power of our language

- E.g. In order to create a system for arithmetic on rational numbers (numbers with numerator & denominator) it would be ideal to represent as one unit (compound data object) rather than two separate numbers.
- If we can manipulate rational numbers as objects own we can separate the logic from the how the data is represented -> increase modularity
- The technique of isolating the parts of a program that represent data and the parts that use the data is a design methodology called "data abstraction"

- To form compound data objects a programming language should provide some "glue" so that data objects can be combined
- The "glue" we use to combine data objects should be able to combine both primitive and compound data objects -> "closure"
- Data objects can serve as "conventional interfaces"
- Procedures which handle many types of data -> "generic operations"

## 2.1 - Introduction to Data Abstraction

- Basic idea is that programs should:

  - Use data in a way that makes no assumptions about the data that is not strictly necessary for the task at hand
  - Have a "concrete" data representation is defined independent of the programs that use the data
  - Have a set of procedures called "selectors" and "constructors" to use as an interface which implements the abstract data in terms of concrete representation

### 2.1.1 Example: Arithmetic Operations for Rational Numbers

- We want to add, subtract, multiply and divide rational numbers and test if they're equal.
- To write these we'll make the assumption that we have the following "constructor" and "selector" procedures available:

  - (make-rat <n> <d>) -> returns a rational number whose numerator is integer <n> an denominator is integer <d>
  - (numer <x>) -> returns integer numerator of rational number <x>
  - (denom <x>) -> returns integer denominator of rational number <x>

- Add, subtract, multiply, divide and equality testing are represented in the following procedures

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

### Pairs

- Scheme provides a compound data structure called a "pair" which is created with the primitive procedure "cons"
- This procedure takes two arguments and returns a compound data object with the two arguments as parts
- We can extract the parts of a pair using "car" and "cdr"

  (define x (cons 1 2))
  (car x) -> 1
  (cdr x) -> 2


- A pair is a data object which can be named and manipulated just like primitive data
- Pairs can be used as general purpose building blocks to create complex data structures (Section 2.2)
- Pairs can also be constructed from other pairs, i.e. ```(cons (cons 1 2) (cons 3 4)) -> ((1 . 2) 3 . 4)
- Data objects constructed from pairs are called "list structured data"

### Representing Rational Numbers

- Rational numbers can be represented as a pair of two integers
- We define the earlier constructor and selectors as follows:

  (define (make-rat n d) (cons n d))
  (define (numer x) (car x))
  (define (denom x) (cdr x))

- We can print our rational numbers with the following procedure

  (define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))

- This implementation does not reduce rationals to their lowest terms, so we modify "make-rat" with "gcd" from section 1.2.5

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

- This modification is able to made without changing any procedures that use rational numbers, i.e. add-rat, mul-rat, etc