# Compiler Lab (IPLL)

A collection of laboratory assignments completed as part of the Implementation of Programming Languages Laboratory (CS348). This repository covers core concepts in programming language implementation, beginning with assembly language programming and progressing through assembler design, lexical analysis, and syntax analysis for a subset of the C programming language called nanoC.

## Repository Overview

The repository contains four major assignments:

| Assignment | Topic | Technologies |
| :--- | :--- | :--- |
| **Assignment 1** | x86 Assembly Programming | NASM, Linux System Calls |
| **Assignment 2** | Assembler Design | C |
| **Assignment 3** | Lexical Analyzer for nanoC | Flex (Lex) |
| **Assignment 4** | Parser for nanoC | Flex + Bison (Yacc) |

The assignments gradually build the foundations of a compiler by moving through the early phases of language processing:
1. Assembly Programming
2. Assembler Construction
3. Lexical Analysis
4. Syntax Analysis

## Directory Structure

```text
CS348/
│
├── 230101039_assignment1_CS348/
│   ├── Assignment 1_SET A.pdf
│   ├── Assignment 1_SET B .pdf
│   ├── 230101039_seta_Q1/
│   ├── 230101039_seta_Q3/
│   ├── 230101039_seta_Q11/
│   ├── 230101039_setb_Q2/
│   ├── 230101039_setb_Q4/
│   └── 230101039_setb_Q6/
│       # Each folder contains its respective .asm, Makefile, and README.md
│
├── 230101039_assignment2_CS348/
│   └── Assignment_2_Assembler/
│       ├── 1PassAssembler.c
│       ├── 2PassAssembler.c
│       ├── Assignment 2.pdf
│       ├── opcodes.txt
│       ├── sample_input.txt
│       ├── sample_intermediate.txt
│       └── sample_output.txt
│
├── 230101039_assignment3_CS348/
│   ├── Assignment3.pdf
│   ├── Makefile
│   ├── a3_230101039.l
│   ├── a3_230101039_test.nc
│   ├── a3_230101039_token.txt
│   └── a3_230101039_st.txt
│
└── 230101039_assignment4_CS348/
    ├── Assignment4.pdf
    ├── Makefile
    ├── README.md
    ├── a4_230101039.l
    ├── a4_230101039.y
    ├── a4_230101039_test.nc
    └── a4_230101039_error_test.nc
```

---

## Assignment 1 – x86 Assembly Programming

This assignment focuses on low-level programming using NASM assembly language and Linux system calls. Solutions are divided into separate folders based on the assigned questions from Set A and Set B.

### Building Assignment 1 Programs

Navigate to the specific question folder (e.g., `230101039_seta_Q11`) and use the provided Makefiles or compile manually:
```bash
nasm -f elf32 230101039_seta_Q11.asm -o program.o
ld -m elf_i386 -o program program.o
./program
```

---

## Assignment 2 – Assembler Design

This assignment implements both a One-Pass Assembler and a Two-Pass Assembler in C.

### One-Pass Assembler
A one-pass assembler processes source code in a single scan.
* **Responsibilities:** Symbol table generation, address assignment, object code generation, and handling forward references.

### Two-Pass Assembler
The assembler performs two scans over the source program.
* **Pass 1:** Builds the symbol table, assigns addresses, and calculates location counters.
* **Pass 2:** Resolves symbols, generates final machine/object code, and produces the executable representation.

### Running

**Two-Pass Assembler**
```bash
gcc 2PassAssembler.c -o twopass
./twopass
```

**One-Pass Assembler**
```bash
gcc 1PassAssembler.c -o onepass
./onepass
```

*Assumption: Input is read from `sample_input.txt` and requires `opcodes.txt` located in the same directory.*

---

## Assignment 3 – Lexical Analyzer for nanoC

This assignment implements a lexer for nanoC, a subset of the C programming language.

* **Objective:** Convert source code into a stream of tokens while simultaneously building a symbol table and reporting lexical errors.
* **Technologies:** Flex (Lex), C, Make

### Build and Run
```bash
make
make run
```

### Outputs Generated
* **Token Stream (`a3_230101039_token.txt`):** Contains token type and line information.
* **Symbol Table (`a3_230101039_st.txt`):** Contains discovered identifiers.

---

## Assignment 4 – Parser for nanoC

This assignment extends the compiler front-end by implementing a parser for nanoC using Bison.

* **Objective:** Validate whether a token stream conforms to the grammar of nanoC.
* **Technologies:** Flex, Bison (Yacc), GCC, Make

### Build
```bash
make clean
make
```
*Generated files: `lex.yy.c`, `y.tab.c`, `y.tab.h`, `a.out`*

### Run
* **Valid Program Test:** `make run` using `a4_230101039_test.nc`
* **Error Test:** Test error handling using `a4_230101039_error_test.nc`

---

## Prerequisites
For Linux/WSL:
```bash
sudo apt-get update
sudo apt-get install -y gcc make flex bison nasm
```

## Author

**Garima Kalra**  
Roll No: 230101039  
B.Tech Computer Science and Engineering (Batch 2023-2027)  
Implementation of Programming Languages Laboratory (CS348)  
Indian Institute of Technology Guwahati  
