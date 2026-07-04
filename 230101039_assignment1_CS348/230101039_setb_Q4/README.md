# Next-ASCII Alphabet Replacer

## Author
**Name:** Garima Kalra  
**Roll No:** 230101039

---
**Target:** `230101039_setb_Q4`     
**Language:** x86 Assembly (NASM, 32-bit)

## Description

Reads an input string from standard input and replaces every alphabet character (case-sensitive) with its next alphabet ASCII character using wrap-around rules implemented in the program. Non-alphabet characters are printed unchanged.

## Exact Behavior (parsing & replacement)

* **Input reading:** The program reads raw bytes from `stdin` into a buffer (`buffer resb 500`). The returned byte count from the `read` syscall controls how many bytes are processed.

* **Per-byte handling:** Each byte is treated as a **character** (not as an integer to be parsed). The code examines the ASCII code and decides:

  * If `A` ≤ c < `Z`: replace with `c + 1` (next uppercase letter).
  * If `c == 'Z'`: replace with `'a'` (wrap to lowercase `a`).
  * If `a` ≤ c < `z`: replace with `c + 1` (next lowercase letter).
  * If `c == 'z'`: replace with `'A'` (wrap to uppercase `A`).
  * Otherwise: print the character unchanged.

* **Example:**

  * Input: `wxyz` → Output: `xyzA`
  * Input: `Hello, Zz!` → Output: `Ifmmp, aA!`

## Implementation notes

* `buffer` holds the input bytes; `temp` is a 1-byte output buffer used for writing characters.
* The program uses Linux `read` (syscall 3) and `write` (syscall 4) for I/O.
* It processes exactly the number of bytes returned by the read syscall (no extra parsing of null-terminated strings).

## How to compile & run

Requirements: Linux (32-bit support), `nasm`, `ld`.

Set `TARGET` to `230101039_setb_Q4` in the Makefile (provided). Then:

```bash
make
./230101039_setb_Q4
```

Then type or paste the input and press Ctrl+D (EOF) if using the terminal, for example:

```
wxyz
```

Output:

```
xyzA
```

## Notes / Limitations

* Input max: buffer size (500 bytes) — the program reads up to that many bytes.
* Behavior is case-sensitive and follows the explicit wrap rules described above.
* No special handling for multi-byte or non-ASCII encodings.


