; Problem 12
; Read a character and display it only if it is an uppercase letter.
; Condition: ('A' <= character) AND (character <= 'Z')
; MASM/TASM/EMU8086 compatible

.MODEL SMALL
.STACK 100H
.DATA
    prompt  DB 'Enter a character: $'
    msg     DB 13,10,'Uppercase character: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, prompt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    MOV BL, AL

    ; AND condition: AL >= 'A' AND AL <= 'Z'
    CMP BL, 'A'
    JB  EXIT_PROGRAM
    CMP BL, 'Z'
    JA  EXIT_PROGRAM

    LEA DX, msg
    MOV AH, 09H
    INT 21H

    MOV DL, BL
    MOV AH, 02H
    INT 21H

EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
