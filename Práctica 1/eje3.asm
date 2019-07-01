;Práctica 1 ejercicio 3
	processor 16f877
	include   <p16f877.inc>
K 	equ H'26'
	org 0
	goto inicio
	org 5
inicio:  movf K, W
	addwf K,w
	movwf K	
	btfsc K,H'7'
	goto reini
	goto inicio
reini:  movlw h'01'
	movwf K
	goto inicio
	end 