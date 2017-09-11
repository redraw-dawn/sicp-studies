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
