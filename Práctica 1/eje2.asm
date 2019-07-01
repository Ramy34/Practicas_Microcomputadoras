;Práctica 1 ejercicio 2
	processor 16f877
	include   <p16f877.inc>
K 	equ H'26'
L 	equ H'27'
A	equ H'2A'
Q	equ H'2B'
	org 0
	goto inicio
	org 5
inicio:  movf K,W
	addwf L,W
	movwf Q
	movlw H'00'
	btfsc H'103',H'0'
	movlw H'01'
	movwf A
	goto inicio
	end 