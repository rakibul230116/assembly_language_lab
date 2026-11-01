TITLE PGM21: FIVE NUMBERS REVERSE ORDER STACK SUM AVERAGE
; CSE 3210 Lab Problem 21 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
NUMS DW 5 DUP(?)
R DW ?
M1 DB 'Enter 5 numbers (one per line):',CR,LF,'$'
M2 DB CR,LF,'Original order : $'
M3 DB CR,LF,'Reverse order  : $'
M4 DB CR,LF,'Sum           = $'
M5 DB CR,LF,'Average       = $'
M6 DB '  remainder $'
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,M1
 MOV AH,9
 INT 21H
 MOV CX,5
 XOR SI,SI         ; SI = array offset
 XOR BX,BX         ; BX = running sum
READ_LOOP:
 CALL INDEC        ; number in AX
 MOV NUMS[SI],AX   ; store in array (original order)
 ADD SI,2
 ADD BX,AX         ; sum = sum + number
 PUSH AX           ; push on stack (for reverse order)
 CALL NEWLINE
 LOOP READ_LOOP
 LEA DX,M2
 MOV AH,9
 INT 21H
 MOV CX,5
 XOR SI,SI
SHOW1:
 MOV AX,NUMS[SI]
 CALL OUTDEC
 MOV AH,2
 MOV DL,' '
 INT 21H
 ADD SI,2
 LOOP SHOW1
 LEA DX,M3
 MOV AH,9
 INT 21H
 MOV CX,5
SHOW2:
 POP AX            ; last number entered comes off first
 CALL OUTDEC
 MOV AH,2
 MOV DL,' '
 INT 21H
 LOOP SHOW2
 LEA DX,M4
 MOV AH,9
 INT 21H
 MOV AX,BX
 CALL OUTDEC
 LEA DX,M5
 MOV AH,9
 INT 21H
 MOV AX,BX
 CWD               ; sign extend AX into DX:AX
 MOV CX,5
 IDIV CX           ; AX = quotient, DX = remainder
 MOV R,DX
 CALL OUTDEC       ; print quotient
 LEA DX,M6
 MOV AH,9
 INT 21H
 MOV AX,R
 CALL OUTDEC
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

NEWLINE PROC          ; prints CR+LF
 PUSH AX
 PUSH DX
 MOV AH,2
 MOV DL,0DH
 INT 21H
 MOV DL,0AH
 INT 21H
 POP DX
 POP AX
 RET
NEWLINE ENDP
END MAIN
