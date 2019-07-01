#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#org 0x1F00, 0x1FFF void loader16F877(void) {}
void main(){
while(1){
   //output_b(0x01); //output_x(Dato de 8 bits) prende 1 led 
   output_b(0xff); //output_x(Dato de 8 bits) Prende todos los leds
   delay_ms(250); //Retardo en ms
   output_b(0x00);
   delay_ms(250);
}//while
}//main
