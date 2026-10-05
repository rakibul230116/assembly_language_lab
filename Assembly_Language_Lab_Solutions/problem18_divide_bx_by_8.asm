; Problem 18
; Divide the unsigned value in BX by 8.
; Repeated right shifts: BX >> 3 = BX / 8.
; Result is left in BX for inspection.
; MASM/TASM/EMU8086 compatible

.MODEL SMALL
.STACK 100H
.DATA
    number DW 0064H       ; 100 decimal

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV BX, number

    SHR BX, 1             ; BX = BX / 2
    SHR BX, 1             ; BX = BX / 4
    SHR BX, 1             ; BX = BX / 8

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
