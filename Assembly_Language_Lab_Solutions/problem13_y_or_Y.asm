; Problem 13
; Read a character. If it is 'y' OR 'Y', display it.
; Otherwise terminate the program.
; MASM/TASM/EMU8086 compatible

.MODEL SMALL
.STACK 100H
.DATA
    prompt DB 'Enter y or Y: $'
    msg    DB 13,10,'You entered: $'
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

    ; OR condition: AL == 'y' OR AL == 'Y'
    CMP BL, 'y'
    JE  DISPLAY_CHAR
    CMP BL, 'Y'
    JE  DISPLAY_CHAR
    JMP EXIT_PROGRAM

DISPLAY_CHAR:
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
