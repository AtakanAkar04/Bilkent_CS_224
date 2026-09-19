# PIC32 I/O Registers: TRIS, PORT and LAT

How the TRIS (direction), PORT (read) and LAT (write) registers are used
in the push-button and seven-segment display programs.

Authors: Atakan Akar, Kerem Varnalı

## a) Registers for the push-button and motor program

TRIXs register: Used for controlling the pins of the microcontroller as input or output.

Pins connected to pushbuttons (Button 0 and Button 1) are as input (1).
Pins connected to the motor control are as output (0).

PORTx register: Used for reading the state of the pushbutton inputs.
PORTBbits.RB0: Reads the state from Button 0.
PORTBbits.RB1: Reads the state from Button 1.

LATx register: Used to write values to the pins connected to the motor for controlling its direction.

Example:
LATBbits.LATB2: Controls the motor state ( to turn  ON and OFF).

## c) Registers for the seven-segment display program

TRISx Register: Used to set the pins of the microcontroller as input or output.
Pins connected to the seven-segment display segments are set as output.
Pins controlling the digit selection are also configured as output.
Example:
TRISB = 0x00: Configures PORTB  output for controlling the display segments.
TRISD = 0x00: Configures PORTD  output for controlling digit selection.

LATx Register: Used to write values to output pins.
It controls which segments of the seven-segment display are turned ON and which digit is active.
Example:
LATB = 0x3F: Writes the pattern for a specific digit.
LATD = 0x01: Activates a specific digit.
