TITLE PGM26: RECURSION FACTORIAL
; CSE 3210 Lab Problem 26 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
M1 DB 'Enter N (0 to 8):',CR,LF,'$'
M2 DB CR,LF,'N! = $'
M3 DB CR,LF,'N must be between 0 and 8$'
R DW ?
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,M1
 MOV AH,9
 INT 21H
 CALL INDEC        ; N in AX
 CMP AX,0
 JL BAD_N
 CMP AX,8
 JG BAD_N          ; 9! does not fit in 16 bits
 PUSH AX           ; N on stack (parameter)
 CALL FACTORIAL    ; AX has N!
 MOV R,AX
 LEA DX,M2
 MOV AH,9
 INT 21H
 MOV AX,R
 CALL OUTDEC
 JMP DONE
BAD_N:
 LEA DX,M3
 MOV AH,9
 INT 21H
DONE:
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

FACTORIAL PROC NEAR   ; book: PGM17_2
; computes factorial recursively
; input: stack on entry - ret. addr. (top), N
; output: AX = N!
 PUSH BP           ; save BP
 MOV BP,SP         ; BP points to stack top
; if N <= 1
 CMP WORD PTR [BP+4],1
 JG FACT_ENDIF     ; no, N > 1
; then
 MOV AX,1          ; result = 1
 JMP FACT_RETURN   ; go to return
FACT_ENDIF:
 MOV CX,[BP+4]     ; get N
 DEC CX            ; N - 1
 PUSH CX           ; save on stack
 CALL FACTORIAL    ; recursive call: AX = (N-1)!
 MUL WORD PTR [BP+4]   ; AX = N * (N-1)!
FACT_RETURN:
 POP BP            ; restore BP
 RET 2             ; return and discard N
FACTORIAL ENDP
END MAIN
