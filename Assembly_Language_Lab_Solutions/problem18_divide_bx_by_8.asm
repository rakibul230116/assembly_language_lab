; Problem 18
; Divide unsigned BX by 8 using SHR
; Display the result

.MODEL SMALL
.STACK 100H

.DATA
    number DW 0064H

.CODE
MAIN PROC

    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Load number into BX
    MOV BX, number

    ; Divide BX by 8
    SHR BX, 1
    SHR BX, 1
    SHR BX, 1

    ; Move result to AX for decimal conversion
    MOV AX, BX

    ; Decimal conversion
    MOV BX, 10
    XOR CX, CX

REPEAT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    OR AX, AX
    JNE REPEAT

    ; Display result
    MOV AH, 02H

PRINT:
    POP DX
    ADD DL, 30H
    INT 21H
    LOOP PRINT

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN