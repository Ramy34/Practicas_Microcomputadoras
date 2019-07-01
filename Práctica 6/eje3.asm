;Práctica 6 Ejercicio 3	
	processor 16f877
	include<p16f877.inc>
	__CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _CP_OFF
	val1 equ 0x21
	val2 equ 0x22
	val3 equ 0x23
	org 0
	goto inicio
	org 5
inicio
	CLRF PORTA ;Limpia el portA
	CLRF PORTB ;Limpia el portB
	BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	CLRF TRISB ;Configura el puerto B como salida
	CLRF ADCON1 ;Configura el puerto A y E como analogicas
	BCF STATUS,RP0 ;Regresa al banco 0
Start
	MOVLW h'C1' ;Configura el pin A0 para el CAD
	MOVWF ADCON0
	BSF ADCON0,h'02'
	call Retardo
Espera	
	BTFSC ADCON0,h'02'
	goto Espera ;Aquí termina de convertir
	MOVF ADRESH,W
	MOVWF val1 
	MOVLW h'C9' ;Configura el pin A1 para el CAD
	MOVWF ADCON0
	BSF ADCON0,h'02'
	call Retardo
Espera1	
	BTFSC ADCON0,h'02'
	goto Espera1
	MOVF ADRESH,W
	MOVWF val2
	MOVLW h'D9' ;Configura el pin A3 para el CAD
	MOVWF ADCON0
	BSF ADCON0,h'02'
	call Retardo
Espera2	
	BTFSC ADCON0,h'02'
	goto Espera2
	MOVF ADRESH,W
	MOVWF val3
Comparacion
	MOVF val1,W
	SUBWF val2, W
	BTFSS STATUS,H'00'
	GOTO com12
	MOVF val3,W
	SUBWF val2, W
	BTFSS STATUS,H'00'
	GOTO led3
	goto led2
com12
	MOVF val1,W
	SUBWF val3, W
	BTFSS STATUS,H'00'
	GOTO led1
	goto led3

led1
	MOVLW H'01'
	MOVWF PORTB
	call Retardo
	goto inicio
led2
	MOVLW H'03'
	MOVWF PORTB
	call Retardo
	goto inicio
led3
	MOVLW H'70'
	MOVWF PORTB
	call Retardo
	goto inicio
include<C:\Users\ramse\Downloads\Pr6\Retardo.inc>
end