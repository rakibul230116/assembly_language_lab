; Problem 24: GCD of two positive single-digit integers
.MODEL SMALL
.STACK 100H
.DATA
    M1 DB 'Enter first digit (1-9): $'
    M2 DB 13,10,'Enter second digit (1-9): $'
    M3 DB 13,10,'GCD = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, M1
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL

    LEA DX, M2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BH, AL
GCD_LOOP:
    CMP BH, 0
    JE GCD_DONE
    XOR AX, AX
    MOV AL, BL
    DIV BH                     ; remainder in AH
    MOV BL, BH
    MOV BH, AH
    JMP GCD_LOOP
GCD_DONE:
    LEA DX, M3
    MOV AH, 09H
    INT 21H
    XOR AX, AX
    MOV AL, BL
    CALL PRINT_NUM
    MOV AH, 4CH
    INT 21H
MAIN ENDP

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
