#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7

int var, periodo = 255,contador = 0,cuenta=0,a=0;
float var1,T,Ton;
char b;

#int_rtcc
clock_isr(){
   contador ++;
   if(contador == 300){
      output_b(a);
      a ++;
      contador = 0;
      }
}

#int_rda
teclado(){
   b = getchar();
   if(b == '{L'){
      cuenta ++;
      printf("Nombre:_______ No. Cuenta XXXXXXXX-X Teoria: 0X Lab: 04 Cont: %d",cuenta);
      delay_ms(1000);
   }
}
void main(){
	T = (0.0000002) * 16 *(periodo + 1);
   setup_port_a(ALL_ANALOG); //Configuracion del puerto A como analogico
   setup_adc(ADC_CLOCK_INTERNAL); //Reloj interno del convertidor AD
   set_adc_channel(0); //Seleccion del canal 0
   setup_ccp2(CCP_PWM); //Configura el PWM
   setup_timer_2(T2_DIV_BY_16,periodo,1); 
   set_timer0(0); //Configura el Timer0 en 00
   setup_counters(RTCC_INTERNAL,RTCC_DIV_256);
   enable_interrupts(INT_RTCC);//Habilita el timer0
   enable_interrupts(INT_RDA);
   enable_interrupts(GLOBAL);
while(1){
   delay_us(20); //Retardo de 20u
   var = read_adc(); //Almacena el valor del convertidor en la variable
   delay_us(20); //Retardo de 20u
   var1 = var * 0.01953;
   Ton = (0.0000002) * 16 * var1;
   set_pwm2_duty(var);
   printf("ANX= %f [V] ANx = %x HEX; AN1 = %u DEC; Ton0 = %f;Ton1 = %f \n\r",var1,var,var,T,Ton); //Imprime el mensaje
   }//while
   }//main
