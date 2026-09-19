// CS224 Computer Organization - Lab 7, Section 1
// Atakan Akar (22203140)
// Date: 17.12.2024
// Lab partner: Kerem Varnalı
// Preliminary work: Part d - Fibonacci numbers on the 4-digit seven-segment display

/*
Configuration for the code below:

Connect portA to J1 Port of 4 Digit Seven Segment Module
Jumpers of portA are : 5V, pull down ( top one to left, other to right )

Connect portE to J2 Port of 4 Digit Seven Segment Module
Jumpers of portE are : 5V, pull down ( top one to left, other to right )

*/

// Hexadecimal values for digits in 7 segment
unsigned char binary_pattern[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
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
           // Digit 1
     PORTA=binary_pattern[digit1];     // Put 2 to the second digit
     PORTE=0x01;                  // Open second digit
     Delay_ms(1);
     // Digit 2
     PORTA=binary_pattern[digit2];     // Put 2 to the second digit
     PORTE=0x02;                  // Open second digit
     Delay_ms(1);

     // Digit 3
     PORTA=binary_pattern[digit3];
     PORTE=0x04;
     Delay_ms(1);

     // Digit 4
     PORTA=binary_pattern[digit4];
     PORTE=0x08;
     Delay_ms(1);

 }

void main() {

 AD1PCFG = 0xFFFF;      // Configure AN pins as digital I/O
 JTAGEN_bit = 0;        // Disable JTAG

 TRISA = 0x00;  //portA is output to D
 TRISE = 0X00;  //portE is output to AN

 while(1)
 {

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
