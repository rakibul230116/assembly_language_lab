; Problem 19
; Rotate the contents of BX 4 positions to the left.
; ROL rotates bits; bits leaving the left side re-enter on the right.
; MASM/TASM/EMU8086 compatible

.MODEL SMALL
.STACK 100H
.DATA
    number DW 1234H

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV BX, number
    ROL BX, 4             ; Rotate BX left by 4 positions

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
