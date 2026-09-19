// CS224 Computer Organization - Lab 7, Section 1
// Atakan Akar (22203140)
// Date: 17.12.2024
// Lab partner: Kerem Varnalı
// Lab work: push-button controlled output

void Wait() {
    Delay_ms(1000);
}

unsigned int i;

void main() {
    AD1PCFG = 0xFFFF;
    DDPCON.JTAGEN = 0;
    TRISA = 0x0000;
    TRISE = 0xFFFF;
    LATA = 0x0000;
    LATE = 0x0000;

    while (1) {
        if (PORTEbits.RE6 == 0) {
            Wait();
            LATAbits.LATA2 = 1;
            for (i = 0; i < 1000; ++i) {
                Delay_ms(1);
                if (PORTEbits.RE6 == 0 && PORTEbits.RE7 == 0)
                    LATAbits.LATA2 = 0;
            }
        } else if (PORTEbits.RE7 == 0) {
            Wait();
            LATAbits.LATA1 = 1;
            for (i = 0; i < 1000; ++i) {
                Delay_ms(1);
                if (PORTEbits.RE6 == 0 && PORTEbits.RE7 == 0)
                    LATAbits.LATA1 = 0;
            }
        } else {
            LATAbits.LATA2 = 0;
            LATAbits.LATA1 = 0;
        }
    }
}
