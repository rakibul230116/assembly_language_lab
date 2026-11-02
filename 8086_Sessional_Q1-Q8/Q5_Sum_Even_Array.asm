; Q5: Sum even numbers in a 6-byte array
.MODEL SMALL
.STACK 100H
.DATA
    ARRAY DB 02H, 05H, 08H, 03H, 06H, 01H
    SUM   DW 0000H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA SI, ARRAY
    MOV CX, 6
    MOV BX, 0000H

L1:
    MOV AL, [SI]
    TEST AL, 01H       ; LSB 0 = even, LSB 1 = odd
    JNZ NEXT
    MOV AH, 00H
    ADD BX, AX
NEXT:
    INC SI
    LOOP L1

    MOV SUM, BX        ; SUM = 0010H
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
