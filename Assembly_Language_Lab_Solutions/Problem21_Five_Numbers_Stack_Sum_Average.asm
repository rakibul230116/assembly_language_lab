; Problem 21: Input five digits, display original/reverse order, sum and average
; EMU8086 / MASM-style, inputs are single digits 0-9.

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter five digits (0-9): $'
    MSG2 DB 13,10,'Original order: $'
    MSG3 DB 13,10,'Reverse order: $'
    MSG4 DB 13,10,'Sum = $'
    MSG5 DB 13,10,'Average = $'
    NUMS DB 5 DUP(?)
    SUM DW 0
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    MOV CX, 5
    LEA SI, NUMS
    XOR BX, BX
INPUT_LOOP:
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV [SI], AL
    INC SI
    XOR AH, AH
    ADD BX, AX
    LOOP INPUT_LOOP
    MOV SUM, BX

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    LEA SI, NUMS
    MOV CX, 5
ORIGINAL:
    MOV DL, [SI]
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H
    INC SI
    LOOP ORIGINAL

    LEA SI, NUMS
    MOV CX, 5
PUSH_LOOP:
    XOR AX, AX
    MOV AL, [SI]
    PUSH AX
    INC SI
    LOOP PUSH_LOOP

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    MOV CX, 5
REVERSE:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    LOOP REVERSE

    LEA DX, MSG4
    MOV AH, 09H
    INT 21H
    MOV AX, SUM
    CALL PRINT_NUM

    LEA DX, MSG5
    MOV AH, 09H
    INT 21H
    MOV AX, SUM
    XOR DX, DX
    MOV BX, 5
    DIV BX
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
