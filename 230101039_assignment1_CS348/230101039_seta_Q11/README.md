# Character Frequency Counter

## Author

**Name:** Garima Kalra  
**Roll No:** 230101039

---

**Target:** `230101039_setb_Q11`  
**Language:** x86 Assembly (NASM, 32-bit)

## Description

Reads a document (raw bytes) from standard input and counts the number of occurrences of every possible byte (0–255). The program then prints three categorized lists showing only items with non-zero counts:

* Alphabets (A–Z then a–z)
* Digits (0–9)
* Special symbols (all other bytes not classified as alphanumeric)

## Exact Parsing & Counting Details

* **Input reading:** Uses the `read` syscall to read up to 1000 bytes into `input_buf` (`resb 1000`). The actual number of bytes read is returned in `eax` and stored in `esi` for processing.
* **Counting representation:** A frequency array `freq` of 256 32-bit integers (`resd 256`) is used. For each byte `b` read, the program does `inc dword [freq + b*4]` to increment the corresponding counter. Thus counts are stored as 32-bit unsigned integers.
* **Character handling:** When printing results:

  * Alphabets: iterates `'A'`..`'Z'` then `'a'`..`'z'`, printing those with non-zero counts.
  * Digits: iterates `'0'`..`'9'`.
  * Special symbols: iterates all byte values 0..255 and skips ranges corresponding to digits and letters to print the remainder.
* **Printing format:** Each printed line is: `<char>:<count>\n`. Counts are converted to decimal using repeated division by 10 and buffered into `num_buf` before writing with the `write` syscall.

## Examples

* Input: `Hello, World! 123` → Output will list `H`, `W`, letters like `d`, `e`, `l`, `o`, digits `1`, `2`, `3`, and special symbols like `,`, ` ` (space), `!`, each with their counts (only lines for which count > 0 are printed).

## How to Compile & Run

Requirements: Linux (32-bit support), `nasm`, `ld`.

Set `TARGET` appropriately (e.g., `230101039_setb_Q11`) in the supplied Makefile. Then:

```bash
make
./230101039_setb_Q11
```

Provide the input (type or paste, then EOF / Ctrl+D). The program prints the categorized counts.

## Notes / Limitations

* Max input size: **1000 bytes** (as read into `input_buf`).
* Counts are 32-bit integers (up to 2³²−1).
* Printing control characters or non-printable bytes may produce unexpected terminal behavior since the program prints the raw byte as the leading character in the output lines.
* Only ASCII / single-byte encodings are supported.


