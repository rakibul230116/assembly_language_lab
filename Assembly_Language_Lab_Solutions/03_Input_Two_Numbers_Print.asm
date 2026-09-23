; Problem 03: Input two single-digit numbers and print them
; Easy version: accepts digits 0-9.

.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'Enter first number (0-9): $'
MSG2 DB 13,10,'Enter second number (0-9): $'
OUT1 DB 13,10,'First number: $'
OUT2 DB 13,10,'Second number: $'

NUM1 DB ?
NUM2 DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input first number
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV NUM1, AL

    ; Input second number
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV NUM2, AL

    ; Print first number
    MOV AH, 09H
    LEA DX, OUT1
    INT 21H

    MOV DL, NUM1
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; Print second number
    MOV AH, 09H
    LEA DX, OUT2
    INT 21H

    MOV DL, NUM2
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
