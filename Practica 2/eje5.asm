	processor 16f877  
	include<p16f877.inc>  
valor1 equ h'21' 
valor2 equ h'22' 
valor3 equ h'23' 
cuenta equ 00h
cte1 equ 20h
cte2 equ 50h 
cte3 equ 60h                 
	org 0 
	goto inicio 
   org 5 
inicio   bsf STATUS,5
	BCF STATUS,6       
	MOVLW H'0'      
	MOVWF TRISB     
	BCF STATUS,5     
	clrf PORTB
	movlw cuenta  
	movwf PORTB
loop2  
	call retardo
	incf PORTB,W
	movwf PORTB
	call retardo
	btfsc PORTB,H'7'
	goto con
	goto loop2
reini:  movlw h'00'
	movwf PORTB
	goto loop2

con movlw h'FF'
	subwf PORTB, W
	BTFSS STATUS, H'02'
	goto loop2
	goto reini
retardo movlw cte1
	movwf valor1 
tres movlw cte2
	movwf valor2 
dos  movlw cte3   
	movwf valor3 
uno  decfsz valor3
	goto uno
	decfsz valor2
	goto dos
	decfsz valor1
	goto tres
	return
	END 
