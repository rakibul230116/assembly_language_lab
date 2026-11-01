; Problem 04: MOV, XCHG, ADD, SUB, INC, DEC, NEG
.MODEL SMALL
.STACK 100H

.DATA
A DW 10
B DW 5

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; MOV: copy B into AX
    MOV AX, A

    ; XCHG: exchange AX and B
    XCHG AX, B

    ; ADD: AX = AX + B
    ADD AX, B

    ; SUB: AX = AX - B
    SUB AX, B

    ; INC: increase AX by 1
    INC AX

    ; DEC: decrease AX by 1
    DEC AX

    ; NEG: change AX to its two's-complement negative
    NEG AX

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
