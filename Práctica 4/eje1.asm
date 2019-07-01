	processor 16f877     ;Indica la versión de procesador  
	include   <p16f877.inc> ;Incluye la librería de la versión del procesador
	org 0H    ;Carga al vector de RESET la dirección de inicio  
	goto inicio  
	org 05H
inicio:BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	movlw 06h
	movwf ADCON1 ;Pone el puerto A como digital         
	MOVLW  3FH  ;Configura el puerto A como entrada  
	MOVWF  TRISA
	MOVLW H'0'      
	MOVWF TRISB ;Configura el puerto B como salida
	BCF STATUS,RP0 ;Regresa al banco 0
	CLRF PORTA ;Limpia el portA
	CLRF PORTB ;Limpia el portB
con1:clrf STATUS
	MOVLW h'00'
	subwf PORTA,W ;Opción 00
	btfsc STATUS,H'02'
	goto cero
	movlw h'02'
	subwf PORTA,W ;Opción 02
	btfsc STATUS,H'02'
	goto uno
	movlw h'04'
	subwf PORTA,w ;Opción 04
	btfsc STATUS,H'02'
	goto dos
	movlw h'08'
	subwf PORTA,W ;Opción 08
	btfsc STATUS,H'02'
	goto tres
	movlw h'10'
	subwf PORTA,w ;Opción 10
	btfsc STATUS,H'02'
	goto cuatro
	goto con1
cero:MOVLW h'00'
	MOVWF PORTB ;Apaga ambos motores
	CLRF STATUS
	goto con1
uno:MOVLW H'02'
	MOVWF PORTB ;Enciende el primer motor en sentido horario
	CLRF STATUS
	goto con1
dos:MOVLW H'03'
	MOVWF PORTB ;Enciende el primer motor en sentido antihorario
	CLRF STATUS
	goto con1
tres:MOVLW H'08'
	MOVWF PORTB ;Enciende el segundo motor en sentido horario
	CLRF STATUS
	goto con1
cuatro:MOVLW H'0C'
	MOVWF PORTB ;Enciende el segundo motor en sentido antihorario
	CLRF STATUS
	goto con1
	END
	