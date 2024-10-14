START:
	LDA 2000H	
	MVI D,FFH		; D= -1
	CPI 64H		; A>99?
	JNC CASE1 		; if yes, jump case 1

DECA:
	INR D 			; D= D+1
	SUI 0AH		; while (A>0), do A-10
	JNC DECA		; if (A>0) continue
	ADI 0AH		; correct negative result
	MOV E,A 		; save units in E
	MOV A,D 		; save tens in A
	RLC
	RLC
	RLC
	RLC 			; tens -> MSB
	ADD E 		; units -> LSB
	CMA
	STA 3000H
	JMP START	

CASE1:		
	CPI C8H		; A>199?
	JNC CASE2 		; if yes, jump to case 2
	SUI 64H		; sub 100
	JMP DECA	

CASE2:
	MVI A,00H
	STA 3000H
	JMP START

END

