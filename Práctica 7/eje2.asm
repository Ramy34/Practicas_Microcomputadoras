;Práctica 7 Ejercicio 2
	processor 16f877
	include<p16f877.inc>
	valor1 equ h'21' 
	valor2 equ h'22' 
	valor3 equ h'23' 
	cuenta equ 80h
	cte1 equ 20h
	cte2 equ 50h 
	cte3 equ 60h 
	org 0
	goto Inicio
	org 5
Inicio
	CLRF PORTB ;Limpia el portB
	BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	CLRF TRISB
	bsf TXSTA, BRGH
	MOVLW D'129' ;Define el baudaje
	MOVWF SPBRG ;A 9600 bauds
	BCF TXSTA, SYNC ;Define la comunicacion asincrona 
	BSF TXSTA, TXEN ;Habilita la transmisión de datos
	BCF STATUS,RP0  ;Cambia la banco 0   
	BSF RCSTA, SPEN ;Habilita el puerto serie
	BSF RCSTA, CREN ;Habilita la recepción de datos
Recibe
	BTFSS PIR1,RCIF ;Comprueba la recepción de datos
	call Recibe
	MOVF RCREG, W ;Pasar el dato recibido a W
	MOVWF TXREG ;Y se mueve al registro de transmisor
	goto Seleccion
Regresa
	BSF STATUS, RP0; Cambia al banco 1
Transmite
	BTFSS TXSTA, TRMT ;Comprueba la transmisión del dato
	GOTO Transmite
	BCF STATUS, RP0 ;Regresa al banco 0
	GOTO Recibe
Seleccion
	movlw h'61'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call a

	movlw h'65'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call e

	movlw h'69'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call i

	movlw h'6F'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call o
	
	movlw h'75'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call u

	movlw h'41'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call A

	movlw h'45'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call E

	movlw h'49'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call I

	movlw h'4F'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call O
	
	movlw h'55'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call U
	
	return
a
	movlw h'5F'
	movwf PORTB
	CLRF STATUS
	return
e
	movlw h'7B'
	movwf PORTB
	CLRF STATUS
	return
i
	movlw h'04'
	movwf PORTB
	CLRF STATUS
	return
o
	movlw h'5C'
	movwf PORTB
	CLRF STATUS
	return
u
	movlw h'1C'
	movwf PORTB
	CLRF STATUS
	return
A
	movlw h'77'
	movwf PORTB
	CLRF STATUS
	return
E
	movlw h'79'
	movwf PORTB
	CLRF STATUS
	return
I
	movlw h'06'
	movwf PORTB
	CLRF STATUS
	return
O
	movlw h'3F'
	movwf PORTB
	CLRF STATUS
	return
U
	movlw h'3E'
	movwf PORTB
	CLRF STATUS
	return
END