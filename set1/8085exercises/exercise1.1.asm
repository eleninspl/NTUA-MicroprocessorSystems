START:
	MVI B,01H
	LDA 2000H
	CPI 00H
	JZ END

FOR:
	RAR
	JC DONE
	INR B
	JNZ FOR	

DONE:
	MOV A,B
	
END:
	CMA
	STA 3000H
	JMP START
	RST 1

END