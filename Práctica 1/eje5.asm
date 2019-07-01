;Práctica 1 ejercico 5
	processor 16f877
	include   <p16f877.inc>
FSR equ H'04'
INDF equ H'00'
STATUS equ H'03'
re equ H'41'
	org 0
	goto in
	org 5
in: movlw H'20'; W = 20
	movwf FSR ; fsr = 20
	movf INDF, W ; w = [FSR]
	movwf re; [41] = w
inicio: incf FSR ; Fsr ++
	subwf INDF, W ; W = [FSR] - W
	btfss STATUS, H'00' ;Compara la bandera
	goto SALVAR
	goto con1
SALVAR: movf INDF, W ; En caso de que cumpla, w = [Fsr]
		movwf re; [41] = w
		goto con1
con1: movf re, w; w = [41]
	btfss FSR, H'06' ; Comparara que no haya llegado a 40
	goto inicio; Continua
	goto ter
ter: goto $
	end