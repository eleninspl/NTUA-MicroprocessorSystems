START:
	CALL KIND
	CPI 00H		; (A==0)?
	JZ INVALID	; if yes, invalid
	CPI 09H		; (A<9)?
	JNC INVALID	; if no, invalid

	MOV B,A	; B= A
	MVI A,00H	; A= 00000001

LOOP1:
	DCR B		; B--
	JZ DONE		; if (B==0), done
	RLC 		; rotate left
	INR A		; A++
	JMP LOOP1	; loop

INVALID:
	MVI A,FFH	; A=11111111
	STA 3000H	; turn LEDs off
	JMP START

DONE:
	STA 3000H	; load output	
	JMP START
END
