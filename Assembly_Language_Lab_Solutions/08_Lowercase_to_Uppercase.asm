; Problem 08: Convert a lowercase letter to uppercase
; Easy version: input one lowercase letter a-z.

.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'Enter a lowercase letter: $'
MSG2 DB 13,10,'Uppercase: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    MOV AH, 01H
    INT 21H

    ; ASCII lowercase -> uppercase
    SUB AL, 20H
    MOV BL, AL

    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV DL, BL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
