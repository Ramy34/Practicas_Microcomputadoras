	processor 16f877     ;Indica la versión de procesador  
	include  <p16f877.inc> ;Incluye la librería de la versión del procesador
	org 0H    ;Carga al vector de RESET la dirección de inicio  
	goto inicio  
	org 05H
inicio:BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	movlw 06h
	movwf ADCON1             
	MOVLW  3FH  ;Configura el puerto A como entrada  
	MOVWF  TRISA
	MOVLW H'0'      
	MOVWF TRISB 
	BCF STATUS,RP0 ;Regresa al banco 0
	CLRF PORTA ;Limpia el portA
	CLRF PORTB ;Limpia el portB
con1:clrf STATUS
	MOVLW h'00'
	subwf PORTA,W ; Opción 00
	btfsc STATUS,H'02'
	goto cero
	movlw h'01' ;Opción 01
	subwf PORTA,W
	btfsc STATUS,H'02'
	goto uno
	movlw h'02' ;Opción 02
	subwf PORTA,w
	btfsc STATUS,H'02'
	goto dos
	movlw h'03'
	subwf PORTA,W ;Opción 03
	btfsc STATUS,H'02'
	goto tres
	movlw h'04'
	subwf PORTA,w ;Opción 04
	btfsc STATUS,H'02'
	goto cuatro
	goto con1
cero:MOVLW h'00'
	MOVWF PORTB ;Apaga ambos motores
	CLRF STATUS
	goto con1
tres:MOVLW H'0A'
	MOVWF PORTB ;Prende ambos motores en sentido horario
	CLRF STATUS
	goto con1
cuatro:MOVLW H'0F'
	MOVWF PORTB ;Prende ambos motores en sentido antihorario
	CLRF STATUS
	goto con1
uno:MOVLW H'0B'
	MOVWF PORTB ;Prende el motor 1 en sentido horario y el motor 2 en sentido antihorario
	CLRF STATUS
	goto con1
dos:MOVLW H'0E' 
	MOVWF PORTB ;Prende el motor 2 en sentido horario y el motor 1 en sentido antihorario
	CLRF STATUS
	goto con1
	END
	