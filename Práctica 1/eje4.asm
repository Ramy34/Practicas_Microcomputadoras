;Práctica 1 ejercicio 4
	processor 16f877
	include   <p16f877.inc>
K 	equ H'26'
	org 0
	goto inicio
	org 5
inicio:  movf K, W	
	incf K, W
	movwF K
	btfsc K, H'03'
	goto con
	goto inicio
con	btfsc K, H'00'
	goto suma
	goto inicio
suma movlw H'07'
	addwf K,W
	movwf K
	btfsc K, H'05'
	goto reini
	goto inicio
reini movlw H'00'
	movwf K
	goto inicio
	end 