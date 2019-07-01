;Práctica 7 Ejercicio 1
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
	GOTO Recibe
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
	movlw h'30'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call CERO

	movlw h'31'
	subwf RCREG,W
	btfsc STATUS,H'02'
	call UNO

	movlw h'32'
	subwf RCREG,W
	btfsc STATUS,H'02'
	goto DOS

	movlw h'33'
	subwf RCREG,W
	btfsc STATUS,H'02'
	goto TRES
	
	movlw h'34'
	subwf RCREG,W
	btfsc STATUS,H'02'
	goto CUATRO

	movlw h'35'
	subwf RCREG,W
	btfsc STATUS,H'02'
	goto CINCO
	goto Regresa

CERO
	MOVLW h'00'
	MOVWF PORTB
	CLRF STATUS
	return
UNO
	MOVLW H'FF'
	MOVWF PORTB
	CLRF STATUS
	return
DOS
	clrf PORTB
	movlw h'80'
	movf PORTB
	call retardo
dos_1
	rrf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'0'
	goto Seleccion
	goto dos_1
TRES
	CLRF PORTB
	movlw h'01'
	movf PORTB
	call retardo
tres_1
	rlf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'7'
	goto Seleccion
	goto tres_1
CUATRO
	CLRF PORTB
	movlw h'80'
	movf PORTB
	call retardo
cuatro_1
	clrf STATUS
 	rrf PORTB,W
	movwf PORTB
	call retardo
	btfss PORTB,H'0'
	goto cuatro_1
cuatro_2
	clrf STATUS
	rlf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'7'
	goto Seleccion
	goto cuatro_2
CINCO
	MOVLW h'00'
	MOVWF PORTB
	call retardo
	MOVLW h'ff'
	MOVWF PORTB
	call retardo
	movlw h'35'
	subwf RCREG,W
	btfsc STATUS,H'02'
	goto CINCO
	goto Seleccion
retardo movlw cte1
	movwf valor1 
tr movlw cte2
	movwf valor2 
d  movlw cte3   
	movwf valor3 
u  decfsz valor3
	goto u
	decfsz valor2
	goto d
	decfsz valor1
	goto tr
	return
END