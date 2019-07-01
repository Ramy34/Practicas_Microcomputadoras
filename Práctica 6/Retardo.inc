;Retardo de 20 micros
;Variables
val0 equ 0x30

Retardo
	movlw .33
	movwf val0

Ciclo
	decfsz val0,h'01'
	goto Ciclo
	return