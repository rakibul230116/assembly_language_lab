; Problem 28: Seven-segment display - illustrative 8255 template
; Assumes common-cathode display and Port A=00h, Control=06h.
; Actual port address/wiring depends on your trainer kit.
.MODEL SMALL
.STACK 100H
.DATA
    SEGMENTS DB 3FH, 06H, 5BH, 4FH, 66H
             DB 6DH, 7DH, 07H, 7FH, 6FH
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV DX, 06H
    MOV AL, 80H
    OUT DX, AL                  ; configure 8255, example only
    MOV AL, SEGMENTS[5]         ; display digit 5
    MOV DX, 00H
    OUT DX, AL
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
