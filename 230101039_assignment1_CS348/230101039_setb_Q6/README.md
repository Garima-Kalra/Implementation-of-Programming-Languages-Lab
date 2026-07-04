# Matrix Transposer

## Author

**Name:** Garima Kalra  
**Roll No:** 230101039  

---

**Target:** `matrix_transpose`  
**Language:** x86 Assembly (NASM, 32-bit)

## Description

This program prompts the user for an integer $n$ and then reads the elements of an $n \times n$ matrix. It calculates the transpose of the given matrix and outputs the transposed elements one by one, each on a new line. It also includes basic validation to ensure the input data meets expected ASCII boundaries.

## Exact Parsing & Processing Details

* **Dimension Input:** The program prints `"Enter Input:"` and reads up to 20 bytes to capture the matrix dimension $n$. A loop converts this ASCII input into a 32-bit integer stored in `n_integer` by repeatedly multiplying the accumulator by $10$ and adding the numerical value of each character.
* **Matrix Reading and Compaction:** The program reads up to 400 bytes into a `matrix` buffer. A `compact_loop` extracts exactly $n \times n$ characters into `comp_matrix`. If it encounters a character with an ASCII value below `'0'`, it immediately branches to `bad_input`, prints `"Invalid Input"`, and exits. 
* **Transpose Logic:** Two nested loops (`outer_loop` and `inner_loop`) iterate through the logical rows and columns (up to `n_integer`). It calculates the 1D array index for the original matrix as $row \times n + col$ (stored in `eax`) and the transposed index as $col \times n + row$ (stored in `ebx`). The values are mapped accordingly into `trans_matrix`.
* **Output:** A second set of nested loops iterates through the computed `trans_matrix`. It prints each character individually via `sys_write`, immediately followed by a newline character.

## Examples

* **Input:**
  ```text
  Enter Input:
  2
  1234
  ```
* **Output:** 
  ```text
  1
  3
  2
  4
  ```

## How to Compile & Run

Requirements: Linux (32-bit support), `nasm`, `ld`.

Assuming your source file is named `230101039_setb_q6.asm`, compile and link it using the following commands:

```bash
nasm -f elf32 230101039_setb_q6.asm -o 230101039_setb_q6.o
ld -m elf_i386 230101039_setb_q6.o -o 230101039_setb_q6
./230101039_setb_q6
```

Provide the dimension $n$, press Enter, and then provide the matrix characters continuously. 

## Notes / Limitations

* **Buffer constraints:** The matrix input buffer is limited to **400 bytes**.
* **Matrix Input Format:** The matrix elements must be provided as a continuous string of characters without spaces or newlines interrupting the logical $n \times n$ extraction.
* **Assembly Syntax Note:** The line `mov [trans_matrix+ebx], [comp_matrix+eax]` attempts a memory-to-memory move. In standard x86 assembly, both operands cannot be memory locations simultaneously; this typically requires a register intermediary (e.g., loading into `al` first). Depending on your NASM configuration and macro setup, this may require adjustment to compile successfully.
