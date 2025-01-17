MVI C,40H		; K1
MVI D,80H		; K2
MVI E,C0H		; K3

INR C			; for correct comparison
INR D			; (A=<K) => (A<K+1) 
INR E

MVI A,10H		; empty the 7-seg we dont need
STA 0B01H
STA 0B02H
STA 0B03H
STA 0B04H
STA 0B05H

MVI A,0DH		; mask for RST 6.5
SIM
EI			; enable interrupt

WAIT:
	JMP WAIT

INTR_ROUTINE:
	CALL KIND
	STA 0B03H	; A= 0000MMMM
	RLC
	RLC
	RLC
	RLC		; A= MMMM0000
	MOV B,A		; B= MMMM0000
	CALL KIND
	STA 0B02H	; A= 0000LLLL
	ADD B		; A= MMMMLLLL 
	MOV B,A
	CALL DISP_NUM
	MOV A,B

	CMP C		; [0...K1]?
	JC RANGE1	; if yes, range1
	CMP D		; (K1...K2]
	JC RANGE2	; if yes, range2
	CMP E		; (K2...K3]
	JC RANGE3	; if yes, range3
	
	MVI A,F7H	; else, range4 -> A= 11110111
	JMP DONE

RANGE1:
	MVI A,FEH	; A= 11111110
	JMP DONE

RANGE2:
	MVI A,FDH	; A= 11111101
	JMP DONE

RANGE3:
	MVI A,FBH	; A= 11111011
	JMP DONE

DONE:
	STA 3000H
	EI
	JMP WAIT

DISP_NUM:
	PUSH PSW
	PUSH D
	
	LXI D,0B00H
	CALL STDM
	CALL DCD

	POP D
	POP PSW
	RET

END
	
