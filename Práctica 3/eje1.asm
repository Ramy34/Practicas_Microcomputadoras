	processor 16f877     ;Indica la versión de procesador  
	include   <p16f877.inc> ;Incluye la librería de la versión del procesador
	org 0H    ;Carga al vector de RESET la dirección de inicio  
	goto inicio  
	org 05H
inicio:  CLRF PORTA ;Limpia el portA
	CLRF PORTB ;Limpia el portB
	BSF STATUS,RP0  ;Cambia la banco 1   
	BCF STATUS,RP1
	movlw 06h
	movwf ADCON1             
	MOVLW  3FH  ;Configura el puerto A como entrada  
	MOVWF  TRISA
	MOVLW H'0'      
	MOVWF TRISB 
	BCF STATUS,RP0 ;Regresa al banco 0
con1:MOVLW 00H
	BTFSc PORTA, 0
	MOVLW H'ff
	MOVWF PORTB
	GOTO con1
	END
	
