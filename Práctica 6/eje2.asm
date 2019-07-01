;Práctica 6 Ejercicio 2
	processor 16f877
	include<p16f877.inc>
	__CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _CP_OFF
	org 0
	goto Inicio
	org 5
Inicio
	CLRF PORTA ;Limpia el portA
	CLRF PORTB ;Limpia el portB
	BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	CLRF TRISB ;Configura el puerto B como salida
	CLRF ADCON1 ;Configura el puerto A y E como analogicas
	BCF STATUS,RP0 ;Regresa al banco 0
	MOVLW h'D9'
	MOVWF ADCON0
Start
	BSF ADCON0,h'02'
	call Retardo
Espera	
	BTFSC ADCON0,h'02'
	goto Espera
	call Resta
	goto Start
include<C:\Users\ramse\Downloads\Pr6\Retardo.inc>
include<C:\Users\ramse\Downloads\Pr6\Resta.inc>
end