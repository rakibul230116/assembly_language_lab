; Problem 15
; Input a lowercase English letter and convert it to uppercase
; using a logic operation.
; ASCII lowercase -> uppercase: clear bit 5 using AND 11011111b.
; Example: 'b' = 01100010b -> 'B' = 01000010b

.MODEL SMALL
.STACK 100H
.DATA
    prompt DB 'Enter a lowercase letter: $'
    msg    DB 13,10,'Uppercase: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, prompt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    ; Clear ASCII bit 5
    AND AL, 0DFH
    MOV BL, AL

    LEA DX, msg
    MOV AH, 09H
    INT 21H

    MOV DL, BL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
