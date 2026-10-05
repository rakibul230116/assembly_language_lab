; Problem 16
; Convert an ASCII digit into its numerical value.
; Example: ASCII '7' = 37H, numerical value = 07H.
; MASM/TASM/EMU8086 compatible

.MODEL SMALL
.STACK 100H
.DATA
    prompt DB 'Enter a digit (0-9): $'
    msg    DB 13,10,'Numeric value (0-9): $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, prompt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    ; Convert ASCII digit to its numerical value
    SUB AL, '0'
    MOV BL, AL

    LEA DX, msg
    MOV AH, 09H
    INT 21H

    ; Convert value back to ASCII only for display
    ADD BL, '0'
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
