	AREA CopyBlock, CODE, READONLY
	EXPORT main
count  EQU 0
sum	   EQU 0
	ENTRY
	
main 
	 LDR r0, =seq
	 MOV r1, #count
	 MOV r2, #sum
avg 
	LDR	r3, [r0], #4
	ADD r1, r1, #1 ; count
	ADD r2, r2, r3 ;sum
	;SDIV r4, r2, r1 ;Compute Avg  | Should get 1 + 9 + 11 = 21 / 3 = 7 | The average should be 7
	TEQ R3, #0x00
		BNE avg
	SUB r1, r1, #1
	SDIV r4, r2, r1
stop SWI 0x11
	
	AREA Block, DATA, READWRITE
seq	DCD 1,9,11,0x00, 11 ; Last number should not be computed on average  put it here just to saw you that is working
	END