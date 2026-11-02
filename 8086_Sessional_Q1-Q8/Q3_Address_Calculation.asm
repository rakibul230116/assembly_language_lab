; Q3: Address calculation and register tracing
; Given word at DS:0120H = 1234H
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
    MOV AX, 2000H
    MOV DS, AX
    MOV BX, 0100H
    MOV SI, 0020H
    MOV AX, [BX+SI]    ; EA = 0100H + 0020H = 0120H
    ADD AX, 0010H      ; AX = 1234H + 0010H = 1244H

    ; Expected:
    ; EA = 0120H
    ; Physical address = 2000H * 10H + 0120H = 20120H
    ; Final AX = 1244H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
