LXI B,0064H		; B= 100

START:
	MVI A,FFH	; A= 11111111
	STA 3000H	; turn LEDs off
	LDA 2000H	; load input
	RLC		; CY= MSB
	JC START	; if (MSB ON), wait 

IS_OFF:
	LDA 2000H	; load input
	RLC		; CY= MSB
	JNC IS_OFF	; if (MSB OFF), wait	
	
IS_ON:
	LDA 2000H	; load input
	RLC		; CY= MSB
	JC IS_ON	; if (MSB ON), wait

SET_TIMER:
	MVI D,C8H	; 20sec= 200*0,1sec (C8H= 200)
LEDS_ON:
	LDA 2000H	; load input
	RLC 		; CY= MSB
	JC EXTEND	; if (MSB ON), extend timer
	MVI A,00H	; A= 00000000
	STA 3000H	; turn LEDs on
	CALL DELB 	; delay
	DCR D 		; D--
	JZ START 	; if (D==0), start again
	JMP LEDS_ON

EXTEND:
	LDA 2000H	; load input
	RLC 		; CY= MSB
	JNC SET_TIMER	; if (MSB OFF), set 20s timer again
	MVI A,00H	; A= 00000000
	STA 3000H	; turn LEDs on
	CALL DELB 	; delay
	DCR D 		; D--
	JZ START 	; if (D==0), start again	
	JMP EXTEND

END



	
