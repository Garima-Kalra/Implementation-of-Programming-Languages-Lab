# Array Min/Max Finder and Index Locator

## Author

**Name:** Garima Kalra  
**Roll No:** 230101039  

---

**Target:** `array_min_max`  
**Language:** x86 Assembly (NASM, 32-bit)

## Description

This program prompts the user to enter a number `n`, followed by an array of space-separated integers. It then parses this input to identify both the minimum and maximum numerical values within the array. Finally, it prints the minimum element, its 0-based location (index), the maximum element, and its location. 

## Exact Parsing & Searching Details

* **Input reading:** The program issues `sys_write` syscalls to display `"Enter n"` and `"Enter Array"`. It uses the `sys_read` syscall to capture `n` (up to 12 bytes) and the space-separated array (up to 1000 bytes into the `array` buffer).
* **Integer parsing (`read_int`):** A custom subroutine loops through the ASCII array buffer byte by byte. It subtracts `'0'` from each character and uses `imul` (multiply by 10) and `add` to construct the 32-bit integer until a space (`' '`) or newline (`10`) is encountered.
* **Min/Max tracking:** 
  * The program initializes tracking variables with extreme boundaries: `mini` is set to `1000000000` and `maxi` is set to `-1000000000`. 
  * As each integer is parsed, it is compared against `[mini]` and `[maxi]`.
  * If a new minimum or maximum is found, the program updates the respective variable and records the current element index (`esi`) in `locmin` or `locmax`.
* **Output formatting:** Once a newline character is detected in the array buffer, the program branches to the `done2` block. It sequentially prints the `"Minimum Element: "`, its `"Location: "`, the `"Maximum Element: "`, and its `"Location: "` by converting the integers back to strings using the `write_int` subroutine (which utilizes repeated division by 10).

## Examples

* **Input:**
  ```text
  Enter n
  5
  Enter Array
  12 4 56 2 9
  ```
* **Output:** 
  ```text
  Minimum Element: 2
  Location: 3
  Maximum Element: 56
  Location: 2
  ```

## How to Compile & Run

Requirements: Linux (32-bit support), `nasm`, `ld`.

Assuming your source file is named `230101039_seta_q3.asm`, compile and link it using the following commands:

```bash
nasm -f elf32 230101039_seta_q3.asm -o 230101039_seta_q3.o
ld -m elf_i386 230101039_seta_q3.o -o 230101039_seta_q3
./230101039_seta_q3
```

Follow the prompts to enter `n` and your space-separated array.

## Notes / Limitations

* **Buffer constraints:** The array input is limited to **1000 bytes**.
* **Input formatting:** The elements inside the array *must* be separated by a single space character. The program checks explicitly for ASCII `32` (`' '`) to delimit integers.
* **Positive Integers Only:** The `read_int` subroutine does not contain logic to check for or parse the ASCII minus sign (`'-'`). Inputting negative numbers will result in erroneous parsing.
