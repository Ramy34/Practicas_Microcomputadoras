#include <16f877.h>
#fuses HS,NOPROTECT,
//#device ADC =8  //Indica la resolucion del convertidor
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7

int var, periodo = 255;
float var1,T,Ton;

void main(){
	T = (0.0000002) * 16 *(periodo + 1);
   setup_port_a(ALL_ANALOG); //Configuracion del puerto A como analogico
   setup_adc(ADC_CLOCK_INTERNAL); //Reloj interno del convertidor AD
   set_adc_channel(0); //Seleccion del canal 0
   setup_ccp2(CCP_PWM); //Configura el PWM
   setup_timer_2(T2_DIV_BY_16,periodo,1); 
while(1){
   delay_us(20); //Retardo de 20u
   var = read_adc(); //Almacena el valor del convertidor en la variable
   delay_us(20); //Retardo de 20u
   Ton = (0.0000002) * 16 * var;
   var1 = var * 0.01953;
   set_pwm2_dutty(var);
   printf("ANX= %f [V] ANx = %x HEX; AN1 = %u DEC; Ton0 = %f;Ton1 = %f \n\r",var1,var,var,T,Ton); //Imprime el mensaje
   }//while
   }//main
