; Problem 10: Display the IBM instruction/character set using jump instructions
; Prints character codes 32 through 126 (printable ASCII characters).
; JMP is used to repeat the loop.

.MODEL SMALL
.STACK 100H

.DATA
MSG DB 'Printable IBM/ASCII Character Set:',13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    MOV BL, 32             ; first printable character

PRINT_LOOP:
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    INC BL
    CMP BL, 127
    JNE PRINT_LOOP         ; jump instruction

    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
