# Cycle Detection in Graph

## Author

**Name:** Garima Kalra
**Roll No:** 230101039

---

**Target:** `230101039_setb_Q2`
**Language:** x86 Assembly (NASM, 32-bit)

---

## Description

This program checks whether a cycle exists in a **directed graph** represented by an adjacency matrix. It uses Depth-First Search (DFS) with a recursion stack (`path_visited`) to detect cycles.

## IMPORTANT — Input must be in ROW-MAJOR format (SINGLE ROW)

**This is mandatory for correct results.**

Row-major (single row) means:

> After `n`, you must give **all `n*n` values in one single line** (one row), from left to right.

The program reads the matrix as a continuous sequence and assumes the order is:

```
row1 → row2 → row3 → ... → row n
```

### Correct input (single row only)

For a graph with 4 nodes, adjacency matrix:

```
[0 1 0 0]
[0 0 1 0]
[0 0 0 1]
[1 0 0 0]
```

You **must** enter it like this:

```
4
0 1 0 0 0 0 1 0 0 0 0 1 1 0 0 0
```

Or without spaces:

```
4
0100001000011000
```

### WRONG input (multi-line)

These will **not be accepted**:

```
4
0 1 0 0
0 0 1 0
0 0 0 1
1 0 0 0
```

Because the program expects the matrix **in one continuous row**.

---

arsing rules)

1. **Number of nodes `n`:**

   * The program reads up to **20 bytes** for the first line and converts consecutive ASCII digits (`'0'`–`'9'`) into a 32-bit integer `n_integer`. Parsing stops at the first non-digit (newline or other).
   * If `n` is malformed (non-digit characters while parsing), the program prints `Invalid Input` and exits.
   * The implementation is sized for `n ≤ 20`.

2. **Adjacency matrix:**

   * The program reads up to **400 bytes** into an input buffer and compacts the data by keeping only `'0'` and `'1'` characters into `adj_compact` in the order they appear (this preserves row-major order when you provide the matrix row by row).
   * If the input does not contain exactly `n * n` `0`/`1` characters (in the row-major order you are expected to provide), the program prints `Invalid Input` and exits.

---

## Output

* Prints `Cycle Found` (with newline) if any directed cycle exists.
* Prints `No Cycle` (with newline) if no cycle exists.
* Prints `Invalid Input` (with newline) if `n` is malformed or if there are not enough `0`/`1` entries in row-major order.

---

## Implementation notes & limits

* `n_integer` is a 32-bit value stored in `resd 1`.
* The program assumes `n ≤ 20`. Arrays (`visited`, `path_visited`, `adj_compact`) are sized for up to 20 × 20 matrix.
* `adj_compact` stores ASCII bytes `'0'` (0x30) and `'1'` (0x31).
* The code uses Linux syscalls `read` (3) and `write` (4) via `int 0x80`.
* The program reads the matrix into a single buffer once; when running interactively, paste the entire matrix block or use EOF so that the `read` returns enough bytes.

---

## How to compile & run

Requirements: Linux with 32-bit ABI support, `nasm`, and `ld`.

**Compile:**

```bash
make
```

**Run:**

```bash
./230101039_setb_Q2
```

Provide the input exactly in **row-major** format as shown in the examples above.

---

