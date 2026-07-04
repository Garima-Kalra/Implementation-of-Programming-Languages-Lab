# Compiler Lab (IPLL)

A collection of laboratory assignments completed as part of the Implementation of Programming Languages Laboratory (CS348). This repository covers core concepts in programming language implementation, beginning with assembly language programming and progressing through assembler design, lexical analysis, and syntax analysis for a subset of the C programming language called nanoC.

## Repository Overview

The repository contains four major assignments:

| Week | Topic | Technologies |
| :--- | :--- | :--- |
| **Week 1** | x86 Assembly Programming | NASM, Linux System Calls |
| **Week 2** | Assembler Design | C |
| **Week 3** | Lexical Analyzer for nanoC | Flex (Lex) |
| **Week 4** | Parser for nanoC | Flex + Bison (Yacc) |

The assignments gradually build the foundations of a compiler by moving through the early phases of language processing:
1. Assembly Programming
2. Assembler Construction
3. Lexical Analysis
4. Syntax Analysis

## Directory Structure

```text
Implementation-of-Programming-Languages-Lab/
│
├── Week1_IPLL/
│   ├── 230101039_seta11.asm
│   ├── 230101039_setb4.asm
│   ├── 230101039_setb6.asm
│   └── Readme.txt
│
├── Week2_IPLL/
│   ├── 230101039_onepass.c
│   ├── 230101039_twopass.c
│   ├── input.txt
│   └── Readme.txt
│
├── Week3_IPLL/
│   ├── a3_230101039.l
│   ├── a3_230101039_test.nc
│   ├── Assignment.md
│   ├── Makefile
│   └── Readme.txt
│
└── Week4_IPLL/
    ├── a4_230101039.l
    ├── a4_230101039.y
    ├── Makefile
    ├── README.md
    ├── test files/
    └── generated parser files/
```

---

## Week 1 – x86 Assembly Programming

This assignment focuses on low-level programming using NASM assembly language and Linux system calls.

### Programs Implemented

**1. Character Frequency Counter**
Reads an input document and computes the frequency of each character appearing in the input.
* **Features:** Reads arbitrary text input, counts occurrences of every character, displays frequencies sorted by ASCII value, and demonstrates array manipulation and character processing in assembly.

**2. Document Transformation Program**
Processes textual input according to assignment specifications.
* **Concepts Used:** String processing, character manipulation, conditional branching, and memory addressing.

**3. Matrix Transposition**
Reads an *n* × *n* matrix and prints its transpose.
* **Features:** Dynamic matrix size input, matrix traversal using nested loops, and demonstrates multidimensional data handling in assembly.
* **Example Input:**
  ```text
  3
  1 2 3
  4 5 6
  7 8 9
  ```
* **Example Output:**
  ```text
  1 4 7
  2 5 8
  3 6 9
  ```

### Building Week 1 Programs

**Example:**
```bash
nasm -f elf32 230101039_seta11.asm -o program.o
ld -m elf_i386 -o program program.o
./program
```

---

## Week 2 – Assembler Design

This assignment implements both a One-Pass Assembler and a Two-Pass Assembler in C.

### One-Pass Assembler
A one-pass assembler processes source code in a single scan.
* **Responsibilities:** Symbol table generation, address assignment, object code generation, and handling forward references.
* **Concepts Demonstrated:** Symbol table management, opcode processing, address resolution, and intermediate code generation.

### Two-Pass Assembler
The assembler performs two scans over the source program.
* **Pass 1:** Builds the symbol table, assigns addresses, and calculates location counters.
* **Pass 2:** Resolves symbols, generates final machine/object code, and produces the executable representation.
* **Advantages:** Easier symbol resolution, better handling of forward references, and cleaner implementation.

### Running

**Two-Pass Assembler**
```bash
gcc 230101039_twopass.c -o twopass
./twopass
```

**One-Pass Assembler**
```bash
gcc 230101039_onepass.c -o onepass
./onepass
```

*Assumption: Input is read from `input.txt` located in the same directory.*

---

## Week 3 – Lexical Analyzer for nanoC

This assignment implements a lexer for nanoC, a subset of the C programming language.

* **Objective:** Convert source code into a stream of tokens while simultaneously building a symbol table and reporting lexical errors.
* **Technologies:** Flex (Lex), C, Make

### Tokens Recognized
* **Keywords:** `int`, `float`, `char`, `while`, `for`, `if`, `return`, `static`
* **Identifiers:** `count`, `temp`, `_result`
* **Constants:** `10`, `45`, `3.14`, `'a'`
* **String Literals:** `"Hello World"`
* **Operators:** `+`, `-`, `*`, `/`, `==`, `!=`, `<=`, `>=`, `&&`, `||`
* **Punctuators:** `;`, `,`, `(`, `)`, `{`, `}`, `[`, `]`

### Symbol Table Generation
The lexer stores unique identifiers encountered during scanning. Typical information recorded:
* Identifier name
* First occurrence
* Symbol table index

### Error Detection
The lexer detects and reports: invalid identifiers, unterminated strings, invalid character constants, illegal symbols, and unterminated comments.

### Build and Run
```bash
make
make run
```
**Cleaning:**
```bash
make clean
```

### Outputs Generated
* **Token Stream (`a3_230101039_token.txt`):** Contains token type and line information.
* **Symbol Table (`a3_230101039_st.txt`):** Contains discovered identifiers.

---

## Week 4 – Parser for nanoC

This assignment extends the compiler front-end by implementing a parser for nanoC using Bison.

* **Objective:** Validate whether a token stream conforms to the grammar of nanoC.
* **Technologies:** Flex, Bison (Yacc), GCC, Make

### Supported Language Constructs
* **Declarations:** `int x;`, `float y;`
* **Function Definitions:** `int add(int a, int b) { return a + b; }`
* **Control Flow:** `if`, `else`, `while`, `do-while`, `for`
* **Arrays:** `int arr[10];`
* **Expressions:** Arithmetic, Relational, Logical, Assignment
* **Initializers:** `int x = 5;`, `int arr[] = {1,2,3};`

### Grammar Features
The parser supports: translation units, declarations, function definitions, declarators, initializers, parameter lists, expressions, statements, and compound statements. The grammar closely follows the nanoC specification derived from ISO C.

### Build
```bash
make clean
make
```
*Generated files: `lex.yy.c`, `y.tab.c`, `y.tab.h`, `parser`*

### Run
* **Valid Program:** `make run` (Expected: Parsing successful)
* **Lexer Error Test:** `make run-lexer-error`
* **Parser Error Test:** `make run-parser-error`

### Generated Outputs
* **Token File:** `a4_230101039_token.txt`
* **Symbol Table:** `a4_230101039_st.txt`

---

## Concepts Covered
This repository demonstrates several important compiler construction concepts:
* **Assembly Language:** Registers, Memory addressing, System calls, String processing, Matrix manipulation
* **Assembler Design:** One-pass assembly, Two-pass assembly, Symbol tables, Location counters, Object code generation
* **Lexical Analysis:** Regular expressions, Tokenization, Lexical errors, Symbol table creation
* **Syntax Analysis:** Context-free grammars, Parsing, Recursive grammar structures, Error reporting, Compiler front-end construction

## Prerequisites
For Linux/WSL:
```bash
sudo apt-get update
sudo apt-get install -y gcc make flex bison nasm
```

## Learning Outcomes
By completing these assignments, the following compiler construction topics are explored:
* Assembly language programming
* Assembler implementation
* Token generation
* Symbol table management
* Lexical analysis using Flex
* Syntax analysis using Bison
* Compiler front-end design
* Language grammar implementation

---

## Author

**Garima Kalra**  
Roll No: 230101039  
Implementation of Programming Languages Laboratory (CS348)  
Department of Computer Science and Engineering  
Indian Institute of Technology Guwahati  
