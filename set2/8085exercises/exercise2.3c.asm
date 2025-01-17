START:	
	IN 10H		
	LXI H,0A00H	; HL=M= 0A00H

	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	INX H

LINE0:	
	MVI A,FEH	; A= 11111110
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX
	MVI C,86H	; code for INSTR STEP
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,85H	; code for FETCH PC
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show

LINE1:	
	MVI A,FDH	; A= 11111101
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX	
	MVI C,84H	; code for RUN
	CPI 06H		; (XXX==110)?	
	JZ SHOW		; if yes, show
	MVI C,80H	; code for FETCH REG
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show
	MVI C,82H	; code for FETCH ADRS
	CPI 03H		; (XXX==011)?
	JZ SHOW		; if yes, show

LINE2:	
	MVI A,FBH	; A= 11111011
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX	
	MVI C,00H	; code for 0
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,83H	; code for STORE/INCR
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show
	MVI C,81H	; code for DECR
	CPI 03H		; (XXX==011)?
	JZ SHOW		; if yes, show

LINE3:	
	MVI A,F7H	; A= 11110111
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX	
	MVI C,01H	; code for 1
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,02H	; code for 2
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show 
	MVI C,03H	; code for 3
	CPI 03H		; (XXX==011)?
	JZ SHOW		; if yes, show

LINE4:	
	MVI A,EFH	; A= 11101111
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX	
	MVI C,04H	; code for 4 
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,05H	; code for 5
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show
	MVI C,06H	; code for 6
	CPI 03H		; (XXX=011)?
	JZ SHOW		; if yes, show

LINE5:	
	MVI A,DFH	; A= 11011111
	STA 2800H	
	LDA 1800H	; read input 
	ANI 07H		; A= 00000XXX	
	MVI C,07H	; code for 7
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,08H	; code for 8
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show
	MVI C,09H	; code for 9
	CPI 03H		; (XXX==011)?
	JZ SHOW		; if yes, show

LINE6:	
	MVI A,BFH	; A= 10111111
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX	
	MVI C,0AH	; code for A
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,0BH	; code for B
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show
	MVI C,0CH	; code for C
	CPI 03H		; (XXX=011)?
	JZ SHOW		; if yes, show

LINE7:	
	MVI A,7FH	; A= 01111111
	STA 2800H	
	LDA 1800H	; read input
	ANI 07H		; A= 00000XXX	
	MVI C,0DH	; code for D
	CPI 06H		; (XXX==110)?
	JZ SHOW		; if yes, show
	MVI C,0EH	; code for E
	CPI 05H		; (XXX==101)?
	JZ SHOW		; if yes, show
	MVI C,0FH	; code for F
	CPI 03H		; (XXX==011)?
	JZ SHOW		; if yes, show

	JMP START	

SHOW:	
	LXI H,0A04H	; HL= 0A04H
	MOV A,C		; A= code (YYYYXXXX)
	ANI 0FH		; A= 0000XXXX
	MOV M,A		; M= A

	INX H		; HL++
	MOV A,C		; A= code (YYYYXXXX)
	ANI F0H		; A= YYYY0000
	RLC		
	RLC		
	RLC		
	RLC		; A= 0000YYYY
	MOV M,A		; M= A

	LXI D,0A00H	; DE= 0A00H	
	CALL STDM	
	CALL DCD	
	JMP START

END
