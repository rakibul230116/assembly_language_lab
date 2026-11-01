TITLE PGM16: ASCII DIGIT TO NUMERICAL VALUE
; CSE 3210 Lab Problem 16 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
P1 DB 'Enter a digit (0-9): $'
P2 DB 0DH,0AH,'Numerical value = $'
P3 DB 0DH,0AH,'In binary       = $'
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,P1
 MOV AH,9
 INT 21H
 MOV AH,1
 INT 21H
 MOV BL,AL
 SUB BL,30H         ; or AND BL,0FH
 XOR BH,BH
 LEA DX,P2
 MOV AH,9
 INT 21H
 MOV AX,BX
 CALL OUTDEC
 LEA DX,P3
 MOV AH,9
 INT 21H
 CALL BINOUT
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

BINOUT PROC           ; prints BX as 16-bit binary (BX preserved)
 PUSH AX
 PUSH BX
 PUSH CX
 PUSH DX
 MOV CX,16
B_TOP:
 MOV DL,'0'
 SHL BX,1
 JNC B_SHOW
 MOV DL,'1'
B_SHOW:
 MOV AH,2
 INT 21H
 LOOP B_TOP
 POP DX
 POP CX
 POP BX
 POP AX
 RET
BINOUT ENDP
END MAIN
