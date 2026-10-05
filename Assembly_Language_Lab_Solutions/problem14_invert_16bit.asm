; Problem 14
; Invert all bits of a 16-bit number stored in memory.
; NOT changes every 0 bit to 1 and every 1 bit to 0.
; MASM/TASM/EMU8086 compatible

.MODEL SMALL
.STACK 100H
.DATA
    number DW 1234H

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Invert all 16 bits stored in memory
    NOT number

    ; Load result into AX so it can be inspected in debugger
    MOV AX, number

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
