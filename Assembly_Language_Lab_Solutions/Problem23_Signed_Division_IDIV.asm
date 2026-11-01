; Problem 23: Signed single-digit division using IDIV
; Input a number from -9 to +9. Type '-' for negative numbers.
; Press Enter after each number. Division by zero is rejected by exit.
.MODEL SMALL
.STACK 100H
.DATA
    M1 DB 'Enter first signed digit (-9 to 9): $'
    M2 DB 13,10,'Enter second signed digit (-9 to 9): $'
    M3 DB 13,10,'Quotient = $'
    M4 DB 13,10,'Remainder = $'
    A DB ?
    B DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, M1
    MOV AH, 09H
    INT 21H
    CALL READ_SIGNED
    MOV A, AL
    LEA DX, M2
    MOV AH, 09H
    INT 21H
    CALL READ_SIGNED
    MOV B, AL
    CMP B, 0
    JE EXIT_PROGRAM

    MOV AL, A
    CBW
    IDIV B                   ; AL=quotient, AH=remainder
    MOV BL, AL
    MOV BH, AH

    LEA DX, M3
    MOV AH, 09H
    INT 21H
    MOV AL, BL
    CALL PRINT_SIGNED

    LEA DX, M4
    MOV AH, 09H
    INT 21H
    MOV AL, BH
    CALL PRINT_SIGNED
EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

READ_SIGNED PROC
    XOR BX, BX
    MOV AH, 01H
    INT 21H
    CMP AL, '-'
    JNE READ_DIGIT
    MOV BL, 1
    MOV AH, 01H
    INT 21H
READ_DIGIT:
    SUB AL, '0'
    CMP BL, 1
    JNE POSITIVE
    NEG AL
POSITIVE:
    PUSH AX
    MOV AH, 01H
    INT 21H                    ; consume Enter
    POP AX
    RET
READ_SIGNED ENDP

PRINT_SIGNED PROC
    CBW
    CMP AX, 0
    JGE PRINT_ABS
    PUSH AX
    MOV DL, '-'
    MOV AH, 02H
    INT 21H
    POP AX
    NEG AX
PRINT_ABS:
    CALL PRINT_NUM
    RET
PRINT_SIGNED ENDP

PRINT_NUM PROC
    XOR CX, CX
    MOV BX, 10
CONVERT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT
DISPLAY:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY
    RET
PRINT_NUM ENDP
END MAIN
