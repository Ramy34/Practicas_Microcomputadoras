#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7

int x;
int time = 500;
char var1;

void main(){
while(1){
   var1=getchar();
   
   switch (var1) {

    case '0': output_b(0x00);

           break;

    case '1': output_b(0xff);

           break;
           
    case '2': x = 0x80;
            while(x != 01){
               output_b(x);
               delay_ms(time);
               rotate_right( &x, 1);
            }
            output_b(x);
            delay_ms(time);
           break;

    case '3': x = 0x01;
            while(x != 0x80){
               output_b(x);
               delay_ms(time);
               rotate_left( &x, 1);
            }
            output_b(x);
            delay_ms(time);
           break;

    case '4': x = 0x80;
            while(x != 01){
               output_b(x);
               delay_ms(time);
               rotate_right( &x, 1);
            }
             while(x != 0x80){
               output_b(x);
               delay_ms(time);
               rotate_left( &x, 1);
            }
            output_b(x);
            delay_ms(time);
           break;

    case '5': output_b(0xff);
            delay_ms(time);
            output_b(0x00);
            delay_ms(time);

           break;

   default:output_b(0xf0);
           delay_ms(time);
           output_b(0x0f);
           delay_ms(time);
            break; }

 

   
   
}//while
}//main
