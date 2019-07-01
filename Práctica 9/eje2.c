#include <16f877.h>
#fuses HS,NOPROTECT,
//#device ADC =8  //Indica la resolucion del convertidor
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7

float conv;
int resultado;
int16 contador = 0;

#int_rtcc
clock_isr(){
contador ++;
if(contador == 770){
   output_b(resultado);
   conv = resultado * 0.01953;
   printf("Voltaje= %f [V] %x HEX %u DEC  \n\r",conv,resultado,resultado);
   contador = 0;
}
}
void main(){
   setup_port_a(ALL_ANALOG); //Configuracion del puerto A como analogico
   setup_adc(ADC_CLOCK_INTERNAL); //Reloj interno del convertidor AD
   set_adc_channel(0); //Seleccion del canal 0
   set_timer0(0);
   setup_counters(RTCC_INTERNAL,RTCC_DIV_256);
   enable_interrupts(INT_RTCC);
   enable_interrupts(GLOBAL);
   while(1){
   delay_us(20);
   resultado = read_adc();
   delay_us(20);
   }
}
