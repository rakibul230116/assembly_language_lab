TITLE PGM22: MULTIPLY TWO UNSIGNED NUMBERS USING MUL
; CSE 3210 Lab Problem 22 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
P1 DB 'Enter first number : $'
P2 DB 0DH,0AH,'Enter second number: $'
P3 DB 0DH,0AH,'Product = $'
P4 DB 0DH,0AH,'Product does not fit in 16 bits$'
R DW ?
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,P1
 MOV AH,9
 INT 21H
 CALL INDEC
 MOV BX,AX
 LEA DX,P2
 MOV AH,9
 INT 21H
 CALL INDEC
 MUL BX            ; DX:AX = AX * BX
 OR DX,DX
 JNZ OVF
 MOV R,AX
 LEA DX,P3
 MOV AH,9
 INT 21H
 MOV AX,R
 CALL OUTUDEC
 JMP QUIT
OVF:
 LEA DX,P4
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

OUTUDEC PROC          ; prints AX as an UNSIGNED decimal integer (0..65535)
 PUSH AX
 PUSH BX
 PUSH CX
 PUSH DX
 XOR CX,CX
 MOV BX,10D
UREPEAT:
 XOR DX,DX
 DIV BX
 PUSH DX
 INC CX
 OR AX,AX
 JNE UREPEAT
 MOV AH,2
UPRINT:
 POP DX
 OR DL,30H
 INT 21H
 LOOP UPRINT
 POP DX
 POP CX
 POP BX
 POP AX
 RET
OUTUDEC ENDP
END MAIN
