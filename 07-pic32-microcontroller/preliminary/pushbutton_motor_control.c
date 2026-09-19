// Push-Button Output Control (PIC32)
//
// Reads two push-buttons on PORTE and drives outputs on PORTA: each
// button turns on its own output for one second; pressing both turns it off.
//
// Authors: Atakan Akar, Kerem Varnalı

/*
Attention!
Configuration for push-button project :

Connect RA0 (PORTA bit 0) to an LED.
Connect RE0 (PORTE bit 0) to a push-button.
Jumpers of PORTA are : 5V, pull-up (both to the left side).
Jumpers of PORTE are : 3V3, pull-up (top one to right, other to left).
*/

void Wait() {
    Delay_ms(1000); // Delay function for 1 second
}
unsigned int i;
void main() {

    AD1PCFG = 0xFFFF;     // Set all analog pins to digital mode
    DDPCON.JTAGEN = 0;    // Disable JTAG for port access

    TRISA = 0x0000;       // Set RA0 (bit 0 of PORTA) as output (LED)
    TRISE = 0xFFFF;       // Set all bits of PORTE as input (push-button)

    LATA = 0x0000;        // Initialize PORTA to turn off LEDs
    LATE = 0x0000;        // Clear PORT E (optional)

    while (1) {
        if (PORTEbits.RE6 == 0) { // Check if push-button on RE0 is pressed (active low)
            Wait();
            LATAbits.LATA2 = 1;   // Turn on LED connected to RA0
            for(i = 0; i < 1000; ++i) {
            Delay_ms(1);
             if(PORTEbits.RE6 == 0 && PORTEbits.RE7 == 0)
                   LATAbits.LATA2 = 0;
     }
        }
        else if (PORTEbits.RE7 == 0) { // Check if push-button on RE0 is pressed (active low)
            Wait();
            LATAbits.LATA1 = 1;   // Turn on LED connected to RA0
            for(i = 0; i < 1000; ++i) {
            Delay_ms(1);
             if(PORTEbits.RE6 == 0 && PORTEbits.RE7 == 0)
                   LATAbits.LATA1 = 0;
     }
        }else {
            LATAbits.LATA2 = 0;
            LATAbits.LATA1 = 0;   // Turn off LED connected to RA0
        }
    }
}
