; Problem 17
; Multiply the unsigned value in AX by 2 using a shift instruction.
; SHL AX,1 is equivalent to AX = AX * 2 for unsigned values
; when no overflow occurs.
; Result is left in AX for inspection.

.MODEL SMALL
.STACK 100H
.DATA
    number DW 0015H       ; 21 decimal

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, number
    SHL AX, 1             ; AX = AX * 2

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
