; Problem 05: Calculate the sum of two single-digit numbers
.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'Enter first number (0-9): $'
MSG2 DB 13,10,'Enter second number (0-9): $'
RESULT DB 13,10,'Sum = $'

NUM1 DB ?
NUM2 DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; First number
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV NUM1, AL

    ; Second number
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV NUM2, AL

    ; Add
    MOV AL, NUM1
    ADD AL, NUM2

    ; Print result label
    MOV BL, AL
    MOV AH, 09H
    LEA DX, RESULT
    INT 21H

    ; Print one-digit sum (0-18)
    MOV AL, BL
    XOR AH, AH
    MOV BL, 10
    DIV BL              ; AL=tens, AH=ones

    MOV BH, AH
    CMP AL, 0
    JE PRINT_ONES

    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

PRINT_ONES:
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
