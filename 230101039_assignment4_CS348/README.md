# nanoC Parser - CS348 Assignment 4

**Roll Number:** 230101039  

---

## 1. Assignment Overview

This assignment involves implementing a lexical analyzer and parser for **nanoC**, a subset of the C programming language based on ISO/IEC 9899:1999 (E) standard.

### Key Components:
- **Lexical Analyzer (Flex):** Tokenizes nanoC source code
- **Parser (Bison):** Builds abstract syntax tree based on phrase structure grammar
- **Grammar Coverage:** Expressions, declarations, statements, and their hierarchical relationships

---

## 2. Files Included

### Source Files:
| File | Purpose |
|------|---------|
| `a4_230101039.l` | Flex specification for lexical analysis (token definitions) |
| `a4_230101039.y` | Bison specification for syntax analysis (grammar rules) |
| `a4_23010139_test.nc` | Test input file with nanoC code samples |
| `Makefile` | Build automation script |
| `README.md` | This documentation file |

---

## 3. Grammar Rules Implemented

### Expressions:
- Primary expressions (identifiers, constants, string literals, parenthesized expressions)
- Postfix expressions (array subscripting, function calls, increment/decrement)
- Unary expressions (prefix increment/decrement, unary operators)
- Arithmetic expressions (multiplicative, additive)
- Shift expressions (left/right shift operators)
- Relational expressions (<, >, <=, >=)
- Equality expressions (==, !=)
- Bitwise expressions (AND, XOR, OR)
- Logical expressions (AND, OR)
- Conditional expressions (ternary operator)
- Assignment expressions (=, +=, -=, *=, /=, %=, <<=, >>=, &=, ^=, |=)

### Declarations:
- Type specifiers (void, char, short, int, long, float, double, signed, unsigned, _Bool)
- Storage class specifiers (static)
- Declarators (identifiers, pointer declarators, array declarators, function declarators)
- Parameter lists and identifier lists
- Initializers (assignment expressions and initialization lists)
- Designators (array and struct member designations)

### Statements:
- Labeled statements (labels, case, default)
- Compound statements (block items)
- Expression statements
- Selection statements (if, if-else)
- Iteration statements (while, do-while, for)
- Jump statements (continue, break, return)

---

## 4. Compilation and Execution

### Prerequisites:
- `flex` (Lexical analyzer generator)
- `bison` (LALR parser generator)
- `gcc` (C compiler)

### Build Instructions:

```bash
# Compile and generate lexer and parser
make

# Run the parser on test input
./a.out < a4_23010139_test.nc

# Clean generated files
make clean
```

### Manual Build (if needed):
```bash
flex a4_230101039.l
bison -d a4_230101039.y
gcc lex.yy.c y.tab.c -o a.out
```

---

## 5. Testing

### Test File: `a4_23010139_test.nc`

The test file covers:
- ✓ Declarations (variables, functions, arrays)
- ✓ Expressions (arithmetic, logical, relational, assignment)
- ✓ Statements (if-else, loops, jumps)
- ✓ Operators (unary, binary, ternary)
- ✓ Complex nested structures
- ✓ Edge cases and boundary conditions

### Expected Output:
The parser will either:
- **Accept** the input if it conforms to the nanoC grammar (exit code 0)
- **Reject** the input and report syntax errors if grammar violations exist

---

## 6. Implementation Notes

### Grammar Modifications:
To handle optional non-terminals (e.g., `argument-expression-listopt`), epsilon productions were introduced:

```
argument-expression-list-opt:
    argument-expression-list
    | /* epsilon */
```

This pattern is applied to all optional elements in the grammar.

### Operator Precedence and Associativity:
The Bison specification includes:
- Operator precedence declarations to resolve shift/reduce conflicts
- Left and right associativity specifications for proper expression parsing
- Correct handling of unary vs. binary operators

### Error Handling:
- Syntax errors are reported with line numbers
- Parser continues to find additional errors when possible
- Error recovery mechanisms are in place for robustness

---

