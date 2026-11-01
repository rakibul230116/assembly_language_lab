; Problem 22: Multiply two unsigned single-digit numbers using MUL
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter first digit: $'
    MSG2 DB 13,10,'Enter second digit: $'
    MSG3 DB 13,10,'Product = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MUL BL                  ; AX = AL * BL
    PUSH AX

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    POP AX
    CALL PRINT_NUM
    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_NUM PROC
    XOR CX, CX
    MOV BX, 10
NEXT_DIGIT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE NEXT_DIGIT
SHOW_DIGIT:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP SHOW_DIGIT
    RET
PRINT_NUM ENDP
END MAIN
