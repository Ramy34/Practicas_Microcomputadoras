#include <16f877.h>
#fuses HS,NOPROTECT,
//#device ADC =8  //Indica la resolucion del convertidor
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7

float conv;
int var1,var2;
int16 contador = 0;

#int_rb
port_rb(){
   var2 = input_b();
   if(var2 == 0x80){
      printf("Interrupcion PB7 activada \n\r");
   }
   if(var2 == 0x40){
      printf("Interrupcion PB6 activada \n\r");
   }
   if(var2 == 0x20){
      printf("Interrupcion PB5 activada \n\r");
   }
   if(var2 == 0x10){
      printf("Interrupcion PB4 activada \n\r");
   }
   if(var2 == 0x00){
      printf("Pulso de bajada \n\r");
   }
}

#int_rtcc
clock_isr(){
contador ++;
if(contador == 770){
   contador = 0;
   }
}

void main(){
   enable_interrupts(INT_RB);
   set_timer0(0);
   setup_counters(RTCC_INTERNAL,RTCC_DIV_256);
   enable_interrupts(INT_RTCC);
   enable_interrupts(GLOBAL);
   while(1){
   //Nada :)
   }
}
