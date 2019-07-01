;Práctica 7 Ejercicio 3
	processor 16f877
	include<p16f877.inc>
	val1 equ 0x31
	val2 equ 0x32
	val3 equ 0x33 
	org 0
	goto inicio
	org 5
inicio
	CLRF PORTA ;Limpia el portA
	BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
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
	MOVLW H'31'
	MOVWF TXREG
	goto Serial
led2
	MOVLW H'32'
	MOVWF TXREG
	goto Serial
led3
	MOVLW H'33'
	MOVWF TXREG
	goto Serial
Serial
	BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	bsf TXSTA, BRGH
	MOVLW D'129' ;Define el baudaje
	MOVWF SPBRG ;A 9600 bauds
	BCF TXSTA, SYNC ;Define la comunicacion asincrona 
	BSF TXSTA, TXEN ;Habilita la transmisión de datos
	BCF STATUS,RP0  ;Cambia la banco 0   
	BSF RCSTA, SPEN ;Habilita el puerto serie

Regresa
	BSF STATUS, RP0; Cambia al banco 1
Transmite
	BTFSS TXSTA, TRMT ;Comprueba la transmisión del dato
	GOTO Transmite
	BCF STATUS, RP0 ;Regresa al banco 0
	GOTO Start

Seleccion
	movlw h'31'
	subwf TXREG,W
	btfsc STATUS,H'02'
	GOTO a

	movlw h'32'
	subwf TXREG,W
	btfsc STATUS,H'02'
	goto e

	movlw h'33'
	subwf TXREG,W
	btfsc STATUS,H'02'
	goto i
	goto Regresa

a
	movlw h'31'
	movwf TXREG
	CLRF STATUS
	goto Transmite
e
	movlw h'32'
	movwf TXREG
	CLRF STATUS
	goto Transmite
i
	movlw h'33'
	movwf TXREG
	CLRF STATUS
	goto Transmite

include<C:\Users\ramse\Downloads\Pr6\Retardo.inc>
END