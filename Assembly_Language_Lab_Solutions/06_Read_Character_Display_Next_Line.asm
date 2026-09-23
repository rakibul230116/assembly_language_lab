; Problem 06: Read a character and display it at the beginning of next line
.MODEL SMALL
.STACK 100H

.DATA
MSG DB 'Enter a character: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Read character
    MOV AH, 01H
    INT 21H

    ; Save character
    MOV BL, AL

    ; New line
    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    MOV AH, 02H
    INT 21H

    ; Display character
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
