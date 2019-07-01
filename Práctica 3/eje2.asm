	processor 16f877     ;Indica la versión de procesador  
	include   <p16f877.inc> ;Incluye la librería de la versión del procesador
	valor1 equ h'21' 
valor2 equ h'22' 
valor3 equ h'23' 
cuenta equ 80h
cte1 equ 20h
cte2 equ 50h 
cte3 equ 60h 
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
	subwf PORTA,W
	btfsc STATUS,H'02'
	goto cero
	movlw h'01'
	subwf PORTA,W
	btfsc STATUS,H'02'
	goto uno
	movlw h'02'
	subwf PORTA,w
	btfsc STATUS,H'02'
	goto dos_1
	movlw h'03'
	subwf PORTA,W
	btfsc STATUS,H'02'
	goto tres_1
	movlw h'04'
	subwf PORTA,w
	btfsc STATUS,H'02'
	goto cuatro
	movlw h'05'
	subwf PORTA,W
	btfsc STATUS,H'02'
	goto cinco
	goto con1
cero:MOVLW h'00'
	MOVWF PORTB
	CLRF STATUS
	goto con1
uno:MOVLW H'FF'
	MOVWF PORTB
	CLRF STATUS
	goto con1
dos_1:clrf PORTB
	movlw h'80'
	movf PORTB
	call retardo
dos:rrf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'0'
	goto con1
	goto dos
tres_1: CLRF PORTB
	movlw h'01'
	movf PORTB
	call retardo
tres: rlf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'7'
	goto con1
	goto tres
cuatro: CLRF PORTB
	movlw h'80'
	movf PORTB
	call retardo
cuatro_1:clrf STATUS
 	rrf PORTB,W
	movwf PORTB
	call retardo
	btfss PORTB,H'0'
	goto cuatro_1
cuatro_2:clrf STATUS
	rlf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'7'
	goto con1
	goto cuatro_2
cinco:MOVLW h'00'
	MOVWF PORTB
	call retardo
	MOVLW h'ff'
	MOVWF PORTB
	call retardo
	goto con1
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
