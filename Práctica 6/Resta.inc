;Restas para comparación
Resta
	movlw h'01'
	subwf ADRESH,W
	BTFSS STATUS,H'00'
	GOTO OP1

	BTFSC STATUS,H'02'
	GOTO OP2

	movlw h'03'
	subwf ADRESH,W
	BTFSS STATUS,H'00'
	GOTO OP2

	BTFSC STATUS,H'02'
	GOTO OP3

	movlw h'05'
	subwf ADRESH,W
	;BTFSS STATUS,H'00'
	GOTO OP3

	;BTFSC STATUS,H'02'
	;GOTO OP3

OP1
	movlw h'01'
	movwf PORTB
	return
OP2
	movlw h'03'
	movwf PORTB
	return
OP3
	movlw h'07'
	movwf PORTB
	return