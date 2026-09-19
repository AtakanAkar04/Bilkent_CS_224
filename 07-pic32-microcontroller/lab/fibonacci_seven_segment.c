// Fibonacci on a Seven-Segment Display (PIC32)
//
// Shows the Fibonacci sequence on a 4-digit seven-segment display by
// multiplexing the digits, holding larger numbers on screen longer.
//
// Authors: Atakan Akar, Kerem Varnalı

unsigned char binary_pattern[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

unsigned int cur = 1;
unsigned int next = 1;
unsigned int temp = 0;
unsigned int digit1 = 0;
unsigned int digit2 = 0;
unsigned int digit3 = 0;
unsigned int digit4 = 0;
unsigned int i;
unsigned int wait;

void show() {
    PORTA = binary_pattern[digit1];
    PORTE = 0x01;
    Delay_ms(1);
    PORTA = binary_pattern[digit2];
    PORTE = 0x02;
    Delay_ms(1);
    PORTA = binary_pattern[digit3];
    PORTE = 0x04;
    Delay_ms(1);
    PORTA = binary_pattern[digit4];
    PORTE = 0x08;
    Delay_ms(1);
}

void main() {
    AD1PCFG = 0xFFFF;
    JTAGEN_bit = 0;
    TRISA = 0x00;
    TRISE = 0x00;

    while (1) {
        digit4 = cur % 10;
        digit3 = (cur / 10) % 10;
        digit2 = (cur / 100) % 10;
        digit1 = (cur / 1000) % 10;
        temp = cur;
        cur = next;
        next = next + temp;
        wait = next * 25;

        for (i = 0; i < wait; i++) {
            show();
        }
    }
}
