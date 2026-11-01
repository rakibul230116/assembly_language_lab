.MODEL SMALL
.STACK 100H

.DATA
    number DW 0015H

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    MOV AX, number
    SHL AX, 1

    ; Convert result into decimal digits
    MOV BX, 10
    XOR CX, CX

REPEAT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    OR AX, AX
    JNE REPEAT

    ; Display digits
    MOV AH, 02H

PRINT:
    POP DX
    ADD DL, 30H
    INT 21H
    LOOP PRINT

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN