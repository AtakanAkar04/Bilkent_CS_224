# Computer Organization: MIPS Assembly, Processor Design and Embedded C

Programs and hardware models that work through a computer from the instruction set down to the hardware:

- **MIPS assembly:** arithmetic, arrays, bit manipulation, recursion, linked lists and reading machine code
- **Processor design:** a single-cycle and a five-stage pipelined MIPS processor in SystemVerilog, with forwarding and hazard handling
- **Memory:** how row-major and column-major traversal affect cache performance
- **Embedded C:** push-button input and a multiplexed seven-segment display on a PIC32 microcontroller

| Topic | Language |
|-------|----------|
| [MIPS assembly basics](01-mips-assembly-basics) | MIPS assembly |
| [Arrays and bit manipulation](02-mips-arrays-and-bit-manipulation) | MIPS assembly |
| [Recursion and linked lists](03-mips-recursion-and-linked-lists) | MIPS assembly |
| [Single-cycle MIPS processor](04-single-cycle-mips-processor) | SystemVerilog |
| [Pipelined MIPS processor](05-pipelined-mips-processor) | SystemVerilog |
| [Cache and matrix traversal](06-cache-and-matrix-traversal) | MIPS assembly |
| [PIC32 microcontroller](07-pic32-microcontroller) | C |

Each folder has the same layout:

- `preliminary/` and `lab/` – the programs, in two stages
- `handout.pdf` – the problem specification
- `materials/` – provided starter code and references (folders 04, 05 and 07)

The `.asm` files run in the [MARS](https://dpetersanderson.github.io/) MIPS simulator.

## 01 – MIPS Assembly Basics
| File | What it does |
|------|--------------|
| `preliminary/reverse_array.asm` | Reads an array from the user, reverses it in place and prints it |
| `preliminary/arithmetic_expression.asm` | Computes `(B / C + D mod B - C) / B` using division and mod subroutines built from repeated subtraction |
| `lab/formula_calculator.asm` | Computes `(A*B) mod C / (A-B)` with a division-by-zero check |
| `lab/array_max_menu.asm` | Menu that finds an array's maximum, counts how often it appears, and counts the elements that divide it |
| `lab/fibonacci.asm` | Loop implementation of the Fibonacci function |

## 02 – Arrays and Bit Manipulation
| File | What it does |
|------|--------------|
| `preliminary/array_frequency_table.asm` | Builds an array and counts how often each value (0–9 and >9) appears |
| `lab/hamming_distance.asm` | Hamming distance between two values |
| `lab/reverse_register_bits.asm` | Reverses the bit order of a register |

## 03 – Recursion and Linked Lists
| File | What it does |
|------|--------------|
| `preliminary/summary_linked_list.asm` | Generates a summary linked list from an existing list |
| `preliminary/register_usage_count.asm` | Counts how often a given register is used in a block of instructions |
| `lab/recursive_division.asm` | Division implemented recursively |
| `lab/reverse_linked_list_display.asm` | Prints a linked list in reverse order using recursion |

## 04 – Single-Cycle MIPS Processor
| File | What it does |
|------|--------------|
| `preliminary/preliminary_report.pdf` | Datapath and control changes planned for the new instructions |
| `lab/single_cycle_mips.sv` | Single-cycle MIPS processor extended with the `bcon` and `xnori` instructions, with a test program in instruction memory |
| `materials/` | Base MIPS model, final datapath diagram, sample programs for the new instructions, FPGA display and pulse controllers |

## 05 – Pipelined MIPS Processor
| File | What it does |
|------|--------------|
| `preliminary/preliminary_report.pdf` | Pipeline hazard analysis |
| `lab/pipelined_mips.sv` | Five-stage pipeline registers (F/D, D/E, E/M, M/W) and a hazard unit with forwarding, stalls and flushes. Contains the parts changed from the given template. |
| `materials/` | Pipelined model template, pipeline datapath diagram, hazard test programs |

## 06 – Cache and Matrix Traversal
| File | What it does |
|------|--------------|
| `preliminary/matrix_row_column_sum.asm` | Fills an N×N matrix and sums it in row-major or column-major order, or shows a single element |
| `preliminary/preliminary_report.pdf` | Preliminary report |
| `lab/lab_report.pdf` | Lab report |

## 07 – PIC32 Microcontroller
Written together with Kerem Varnalı.

| File | What it does |
|------|--------------|
| `preliminary/register_answers.md` | How the TRIS, PORT and LAT registers are used |
| `preliminary/pushbutton_motor_control.c`, `lab/pushbutton_motor_control.c` | Drives outputs from two push-buttons |
| `preliminary/fibonacci_seven_segment.c`, `lab/fibonacci_seven_segment.c` | Shows Fibonacci numbers on a 4-digit seven-segment display |
| `materials/` | Example project, programmer tools, board schematics, PIC32 I/O port reference |
