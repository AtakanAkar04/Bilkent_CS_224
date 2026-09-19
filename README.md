# CS224 Computer Organization Labs

Lab assignments for **CS224: Computer Organization** at Bilkent University (Fall 2024).
Labs 1–3 and 6 are written in **MIPS assembly**, Labs 4–5 model a MIPS processor in **SystemVerilog**, and Lab 7 programs a **PIC32 microcontroller** in C.

Every lab folder follows the same layout:

| File | Contents |
|------|----------|
| `LabN_Prelim` | Preliminary work, submitted before the lab session |
| `LabN_Labwork` | Work completed during the lab session |
| `LabN_Handout.pdf` | The official lab assignment |
| `Materials/` | Course-provided starter files (Labs 4, 5 and 7) |

## Lab 1 – Introduction to MIPS Assembly
- **Preliminary:** read an array from the user and process it; evaluate an arithmetic expression from user inputs.
- **Labwork:**
  1. *Formula:* compute `(A*B) mod C / (A-B)` with division-by-zero checks.
  2. *Menu:* array menu that finds the maximum, counts how often it appears, and counts the elements that divide it.
  3. *Fibonacci:* generate Fibonacci numbers.

## Lab 2 – Arrays, Bit Manipulation and Subprograms
- **Preliminary:** build an array dynamically and compute a frequency table of its elements (0–9 and >9).
- **Labwork:**
  1. *Hamming distance* between two values.
  2. *Reversing a register:* reverse the bit order of a register.

## Lab 3 – Recursion and Linked Lists
- **Preliminary:**
  1. Generate a summary linked list from an existing list.
  2. *Register count:* count how often a register is used in a block of instructions.
- **Labwork:**
  1. Recursive division.
  2. Display a linked list in reverse order recursively.

## Lab 4 – MIPS Single-Cycle Datapath and Controller
- **Preliminary:** datapath and control changes needed for the new instructions (`Lab4_Prelim.pdf`).
- **Labwork:** SystemVerilog single-cycle MIPS processor extended with the new `bcon` and `xnori` instructions, tested with a program in `imem`.
- **Materials:** the complete MIPS model, the final datapath diagram, sample programs for the new instructions, and the display and pulse controllers for the FPGA board.

## Lab 5 – Pipelined MIPS Processor
- **Preliminary:** pipeline hazard analysis (`Lab5_Prelim.pdf`).
- **Labwork:** five-stage pipelined MIPS processor with pipeline registers (F/D, D/E, E/M, M/W) and a hazard unit that handles forwarding, stalls and flushes.
- **Materials:** the pipelined model to fill in, the pipeline datapath diagram and sample hazard tests.

## Lab 6 – Cache Memories
- **Preliminary:** `Lab6_Prelim.pdf`, with the code in `Lab6_Prelim_Code.txt`: an N×N matrix program with row-major summation, column-major summation and element lookup, used to compare cache behavior.
- **Labwork:** cache performance experiments (`Lab6_Labwork.pdf`).

## Lab 7 – Programming the PIC32 Microcontroller
- **Preliminary:**
  - a) and c): how the TRIS, PORT and LAT registers are used.
  - b) Push-button control of LEDs and a DC motor.
  - d) Show a number sequence on a 4-digit seven-segment display.
- **Labwork:** push-button controlled output with two buttons, written in C for the PIC32.
- **Materials:** example project, programmer tools, board schematics, PIC32 I/O port reference and a seven-segment display example.
