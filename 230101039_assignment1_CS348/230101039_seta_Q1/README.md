# Character Search and Iteration Counter

## Author

**Name:** Garima Kalra  
**Roll No:** 230101039  

---

**Target:** `230101039_seta_q1`  
**Language:** x86 Assembly (NASM, 32-bit)

## Description

Reads a document (string of raw bytes) and a target character from standard input. The program searches for the first occurrence of the specified character within the document. If the character is found, it prints `1` followed by the number of iterations (the 0-based index) it took to locate the character. If the character is not found in the input document, the program outputs `0`.

## Exact Parsing & Searching Details

* **Input reading:** Uses the `read` syscall to read up to 1000 bytes into `buff` (`resb 1000`). The actual number of bytes read is returned in `eax` and stored in `esi` to act as a countdown counter for the search. A subsequent `read` syscall fetches a single byte into `charr` to act as the search target.
* **Search representation:** A loop (`search_loop`) traverses the buffer. `edi` is used as the memory pointer for the current byte in `buff`, and `ecx` acts as the iteration counter (starting at 0). 
* **Match handling (Found):** If the byte in `buff` matches `charr`, the program branches to `found`. It prints `1`, a newline, and `"no of iterations: "`. The iteration count stored in `ecx` is then converted to an ASCII decimal string via repeated division by 10. The digits are buffered backwards into `numstr` before being written to standard output using the `write` syscall.
* **Match handling (Not Found):** If the countdown counter `esi` drops to 0 or below before a match is found, the program branches to `not_found`, prints `0`, and cleanly exits.

## Examples

* **Scenario 1 (Match Found):**
  * **Doc Input:** `Hello, World!`
  * **Char Input:** `W`
  * **Output:** 
    ```text
    1
    no of iterations: 7
    ```
* **Scenario 2 (No Match):**
  * **Doc Input:** `Assembly`
  * **Char Input:** `z`
  * **Output:**
    ```text
    0
    ```

## How to Compile & Run

Requirements: Linux (32-bit support), `nasm`, `ld`.

If you have a Makefile configured for 32-bit NASM assembly, set your `TARGET` accordingly. Alternatively, compile and link manually:

```bash
nasm -f elf32 230101039_seta_q1.asm -o 230101039_seta_q1.o
ld -m elf_i386 230101039_seta_q1.o -o 230101039_seta_q1
./230101039_seta_q1
```

Follow the standard output prompts (`Enter Doc: ` and `Enter char: `) to provide your inputs.

## Notes / Limitations

* Max document input size: **1000 bytes** (as read into `buff`).
* The program only identifies the **first** occurrence of the specified character and then exits.
* When typing input in a terminal, pressing `Enter` submits a newline character (`\n` or `0x0A`). Depending on how you provide input, the newline might be accidentally captured as part of the document buffer or as the target character. 
* Designed strictly for ASCII / single-byte encodings.
