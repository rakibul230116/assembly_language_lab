TITLE PGM4: ALL OPERATIONS (MOV XCHG ADD SUB INC DEC NEG)
; CSE 3210 Lab Problem 04 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
R1 DW ?
R2 DW ?
M1 DB 'AX = $'
M2 DB 0DH,0AH,'BX = $'
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 MOV AX,5        ; AX = 5
 MOV BX,9        ; BX = 9
 XCHG AX,BX      ; AX = 9, BX = 5
 ADD AX,BX       ; AX = 14
 SUB AX,4        ; AX = 10
 INC AX          ; AX = 11
 DEC BX          ; BX = 4
 NEG BX          ; BX = -4
 MOV R1,AX
 MOV R2,BX
 LEA DX,M1
 MOV AH,9
 INT 21H
 MOV AX,R1
 CALL OUTDEC
 LEA DX,M2
 MOV AH,9
 INT 21H
 MOV AX,R2
 CALL OUTDEC
; DOS exit
 MOV AH,4CH
 INT 21H
MAIN ENDP

OUTDEC PROC           ; prints AX as a signed decimal integer (book: PGM9_1)
 PUSH AX           ; save registers
 PUSH BX
 PUSH CX
 PUSH DX
; if AX < 0
 OR AX,AX          ; AX < 0 ?
 JGE END_IF1       ; no, >= 0
; then
 PUSH AX           ; save number
 MOV DL,'-'
 MOV AH,2
 INT 21H           ; print '-'
 POP AX            ; get AX back
 NEG AX            ; AX = -AX
END_IF1:
; get decimal digits
 XOR CX,CX         ; CX counts digits
 MOV BX,10D        ; BX has divisor
REPEAT1:
 XOR DX,DX         ; prepare high word of dividend
 DIV BX            ; AX = quotient, DX = remainder
 PUSH DX           ; save remainder on stack
 INC CX            ; count = count + 1
; until
 OR AX,AX          ; quotient = 0 ?
 JNE REPEAT1       ; no, keep going
; convert digits to characters and print
 MOV AH,2
PRINT_LOOP:
 POP DX            ; digit in DL
 OR DL,30H         ; convert to character
 INT 21H           ; print digit
 LOOP PRINT_LOOP
 POP DX            ; restore registers
 POP CX
 POP BX
 POP AX
 RET
OUTDEC ENDP
END MAIN
