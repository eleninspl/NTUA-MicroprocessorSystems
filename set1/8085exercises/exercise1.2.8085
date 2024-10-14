IN 10H
LXI B,01F4H 		; delay of 500ms
MVI E,FEH 		; starting point (LSB is on)

START:
	CALL DELB 	; delay
	LDA 2000H	; load input
	ANI 03H		; nullifies all bits except the 2 LSBs
	CPI 01H		; (1stLSB==1 && 2ndLSB==0)?
	JZ LEFT		; if yes, move left

RETURN:
	CPI 00H		; (1stLSB==0 && 2ndLSB==0)?
	JZ CYCLE_L	; if yes, do left cycle
	MOV A,E		; the 2ndLSB is on, so stop
	STA 3000H	; print
	JMP START

LEFT:
	MOV A,E
	CPI 7FH		; (MSB is on)?	7EH= 01111111 
	JZ RIGHT 	; if yes, move right
	RLC		; rotate left
	STA 3000H	; print
	MOV E,A
	JMP START

CYCLE_L:
	MOV A,E
	RLC		; rotate left
	STA 3000H	; print
	MOV E,A
	JMP START	

RIGHT:
	MOV A,E
	CPI FEH		; (LSB is on)?	 FEH= 11111110
	JZ LEFT		; if yes, move left
	RRC	 	; rotate right
	STA 3000H	; print
	MOV E,A
	CALL DELB	; delay
	LDA 2000H	; load input
	ANI 03H		; nullifies all bits except the 2 LSBs
	CPI 01H		; (1stLSB==1 && 2ndLSB==0)?
	JZ RIGHT	; if yes, move left
	JMP RETURN	; else return

END

