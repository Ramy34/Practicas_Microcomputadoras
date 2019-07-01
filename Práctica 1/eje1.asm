;Práctica 1 ejercicio 1
	processor 16f877
	include   <p16f877.inc>
K 	equ H'26'
L 	equ H'27'
	org 0
	goto inicio
	org 5
inicio:  movlw h'05'
	addwf K,0
	movwf L
	goto inicio
	end 