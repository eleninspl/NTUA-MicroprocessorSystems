MVI A,10H		; empty the 4 rightmost 7-seg
STA 0B00H
STA 0B01H
STA 0B02H
STA 0B03H

MVI A,0DH		; mask for RST 6.5
SIM
EI			; enable interrupts

WAIT:
	JMP WAIT	; wait for interrupt

INTR_ROUTINE:
	LXI B,0032H	; B= 50 -> 0.05sec
	EI		; enable interrupts

	MVI E,2DH	; E=45 for timer
NEW_SEC:
	CALL NEXT_SEC	
	MVI D,0AH	; D=10 -> 0.05*10= 0.5s
	
	MVI A,00H
	STA 3000H	; turn LEDs on
LEDS_ON:
	CALL DISP_TIMER
	CALL DELB	; delay 0.05sec
	DCR D		; D--
	JNZ LEDS_ON
	
	MVI D,0AH	; D=10 -> 0.05*10= 0.5s

	MVI A,FFH
	STA 3000H	; turn LEDs off
LEDS_OFF:
	CALL DISP_TIMER	
	CALL DELB	; delay
	DCR D		; D--
	JNZ LEDS_OFF

	DCR E		; E--
	JNZ NEW_SEC

	JMP WAIT	; end of interrupt routine


NEXT_SEC:
	PUSH PSW
	PUSH B
	PUSH H

	MVI B,FFH	; B=-1 -> tens
	MOV A,E		; A= timer 
LOOP1:
	INR B
	SUI 0AH
	JNC LOOP1

	ADI 0AH		; fix negative result/ A-> units
	STA 0B04H	; store units at 1rst 7-seg
	MOV A,B
	STA 0B05H	; store tens at 2nd 7-seg

	POP H
	POP B
	POP PSW
	RET

DISP_TIMER:
	PUSH PSW
	PUSH D

	LXI D,0B00H
	CALL STDM
	CALL DCD

	POP D
	POP PSW
	RET

END
