IN 10H
MVI A,00H  		; A= 00H
MVI D,00H		; D= 00H
LXI H,0900H		; M= HL= 0900H
LXI B,0000H 		; BC= 0000H

MOV M,A			; store 0

STORE:
	INX H 		; HL++
	INR A 		; A++
	MOV M,A	; M= A
	CALL RANGE
	CALL COUNT_1	
	CPI 7FH		; (A==127)?
	JNZ STORE	; if no, store
	JMP DONE


COUNT_1:
	MVI E,08H	; E= 8
LOOP1:
	RLC		; rotate with carry
	JC IS_1		; if (CY==1), BC++
CONT_LOOP1:
	DCR E		; E++
	JNZ LOOP1	; if (E!=0), loop1
	RET		; else return
IS_1:	
	INX B 		; BC++
	JMP CONT_LOOP1

RANGE:
	CPI 10H 	; (A<10H)?
	JC NOT_RANGE	; if yes, not in range
	CPI 61H		; (A<=60H)?
	JNC NOT_RANGE	; if no, not in range
	INR D		; D++
NOT_RANGE:
	RET

DONE:
	RST 1
	END
