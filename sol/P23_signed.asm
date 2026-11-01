TITLE PGM23: SIGNED DIVISION USING IDIV
; CSE 3210 Lab Problem 23 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
P1 DB 'Enter dividend (signed): $'
P2 DB 0DH,0AH,'Enter divisor (signed) : $'
P3 DB 0DH,0AH,'Quotient  = $'
P4 DB 0DH,0AH,'Remainder = $'
P5 DB 0DH,0AH,'Division by zero!$'
QUOT DW ?
REMN DW ?
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,P1
 MOV AH,9
 INT 21H
 CALL INDEC
 MOV SI,AX
 LEA DX,P2
 MOV AH,9
 INT 21H
 CALL INDEC
 MOV BX,AX
 OR BX,BX
 JZ DIVZERO
 MOV AX,SI
 CWD               ; sign-extend AX into DX:AX
 IDIV BX           ; AX = quotient, DX = remainder
 MOV QUOT,AX
 MOV REMN,DX
 LEA DX,P3
 MOV AH,9
 INT 21H
 MOV AX,QUOT
 CALL OUTDEC
 LEA DX,P4
 MOV AH,9
 INT 21H
 MOV AX,REMN
 CALL OUTDEC
 JMP QUIT
DIVZERO:
 LEA DX,P5
 MOV AH,9
 INT 21H
QUIT:
; DOS exit
 MOV AH,4CH
 INT 21H
MAIN ENDP

INDEC PROC            ; reads a number in range -32768 to 32767 -> AX (book: PGM9_3)
 PUSH BX           ; save registers used
 PUSH CX
 PUSH DX
; print prompt
IN_BEGIN:
 MOV AH,2
 MOV DL,'?'
 INT 21H           ; print '?'
; total = 0
 XOR BX,BX         ; BX holds total
; negative = false
 XOR CX,CX         ; CX holds sign
; read a character
 MOV AH,1
 INT 21H           ; character in AL
; case character of
 CMP AL,'-'        ; minus sign?
 JE IN_MINUS       ; yes, set sign
 CMP AL,'+'        ; plus sign?
 JE IN_PLUS        ; yes, get another character
 JMP IN_REPEAT     ; start processing characters
IN_MINUS:
 MOV CX,1          ; negative = true
IN_PLUS:
 INT 21H           ; read a character
; end_case
IN_REPEAT:
; if character is between '0' and '9'
 CMP AL,'0'        ; character >= '0'?
 JNGE IN_NOTDIGIT  ; illegal character
 CMP AL,'9'        ; character <= '9'?
 JNLE IN_NOTDIGIT  ; no, illegal character
; then convert character to a digit
 AND AX,000FH      ; convert to digit
 PUSH AX           ; save on stack
; total = total x 10 + digit
 MOV AX,10D        ; get 10
 MUL BX            ; AX = total x 10
 POP BX            ; retrieve digit
 ADD BX,AX         ; total = total x 10 + digit
; read a character
 MOV AH,1
 INT 21H
 CMP AL,0DH        ; carriage return?
 JNE IN_REPEAT     ; no, keep going
; until CR
 MOV AX,BX         ; store number in AX
; if negative
 OR CX,CX          ; negative number?
 JE IN_EXIT        ; no, exit
; then
 NEG AX            ; yes, negate
; end_if
IN_EXIT:
 POP DX            ; restore registers
 POP CX
 POP BX
 RET
; here if illegal character entered
IN_NOTDIGIT:
 MOV AH,2          ; move cursor to a new line
 MOV DL,0DH
 INT 21H
 MOV DL,0AH
 INT 21H
 JMP IN_BEGIN      ; go to beginning
INDEC ENDP

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
