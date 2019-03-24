; The example tha i worked on is this one : 
;
; x = [3 9 5 52 3 8 6 2 2 9 ] 
; So the medians will be : 
;
; y[0] = median[3 3 9] = 3
; y[1] = median[3 4 9] = 4
; y[2] = median[4 9 52] = 9
; y[3] = median[3 4 52] = 4
; y[4] = median[3 8 52] = 8
; y[5] = median[3 6 8] = 6
; y[6] = median[2 6 8] = 6
; y[7] = median[2 2 6] = 2
; y[8] = median[2 2 9] = 2
; y[9] = median[2 9 9] = 9
;
; the dest data will be [3 4 9 4 8 6 6 2 2 9 ] 

	AREA median, CODE, READONLY
	EXPORT main
first  EQU 3 
last   EQU 9
num    EQU 8
	ENTRY

main 
 LDR r0, =src
 LDR r1, =dest
 MOV r2, #num
 
 ; Here is the first part y[0] = median[3 3 9] = 3
 MOV r3, #first
 LDR r4, [r0], #4
 LDR r5, [r0], #8
 
 CMP R3, R4    ;  if (R3 > R4)
 MOVGT R9, R3  ;  Then r9 = r3 (r9 = max)
 MOVGT R10, R4 ; Then r10 = R4 (R10 = min)
 MOVLE R9, R4  ; else r9 = r4
 MOVLE R10, R3 ; esle r10 = r3
 CMP R5, R9    ; if (r5 > r9)
 MOVGT R9, R5  ; then R9 = R5
 CMP R10, R5   ; if (R10 > R5)
 MOVGT R10, R5 ; then R10 = R5
 add R11, R3, R4  ; R11 = r3 + r4 |  R11 is middle
 ADD R11, R11, R5 ; R11 = R11 + R5
 SUB R11, R11, R9 ; R11 = R11 - R9
 SUB R11, R11,R10 ; R11 = R11 - R10
 
 STR R11, [r1], #4 ; Store the value of R11 to dest
 
 LDR r0, =src ; init the data area again for the loop 
med 
; This loop computes the median from y[1] to y[8]
	LDMIA	R0, {R3,R4,R5}
	
	CMP R3, R4    
	MOVGT R9, R3  
	MOVGT R10, R4 
	MOVLE R9, R4  
	MOVLE R10, R3 
	CMP R5, R9    
	MOVGT R9, R5  
	CMP R10, R5   
	MOVGT R10, R5 
	add R11, R3, R4 
	ADD R11, R11, R5
	SUB R11, R11, R9
	SUB R11, R11,R10 
	
	STR	R11, [r1], #4
	LDR	R3, [r0], #4
	
	SUBS R2, r2, #1
		BNE med
	
	; Here is the last Part y[9] = median[2 9 9] = 9
	MOV R3, R4
	MOV R4, R5
	MOV R5, #last
	CMP R3, R4    
	MOVGT R9, R3  
	MOVGT R10, R4 
	MOVLE R9, R4  
	MOVLE R10, R3 
	CMP R5, R9    
	MOVGT R9, R5  
	CMP R10, R5   
	MOVGT R10, R5 
	ADD R11, R3, R4  
	ADD R11, R11, R5
	SUB R11, R11, R9
	SUB R11, R11,R10
	
	STR	R11, [r1], #4 ;Store the value of R11 to dest
	
	; This is a test just to check i have saved the right values
	LDR R8, =dest
testnum EQU 10
	MOV R9, #testnum
wordcopy
	LDR r10, [r8], #4
	SUBS R9,R9,#1
		BNE wordcopy
	; End of Test
	
stop SWI 0x11 ;software interrupt

	AREA Block, DATA, READWRITE
src	 DCD 3,9,4,52,3,8,6,2,2,9 
dest DCD 0,0,0,0,0,0,0,0,0
	END