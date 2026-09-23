; Problem 09: Perform an operation and display flag values
; Operation: 0FFFFH + 0001H = 0000H
; This sets Carry Flag and Zero Flag.

.MODEL SMALL
.STACK 100H

.DATA
MSG DB 'Operation: FFFFH + 0001H',13,10,'$'
CFMSG DB 13,10,'Carry Flag (CF) = $'
ZFMSG DB 13,10,'Zero Flag (ZF) = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    MOV AX, 0FFFFH
    ADD AX, 0001H

    ; Save flags before DOS interrupts change them
    PUSHF
    POP BX

    ; Display CF
    MOV AH, 09H
    LEA DX, CFMSG
    INT 21H

    MOV AX, BX
    AND AX, 0001H
    CALL PRINT_DIGIT

    ; Display ZF
    MOV AH, 09H
    LEA DX, ZFMSG
    INT 21H

    MOV AX, BX
    AND AX, 0040H
    CMP AX, 0
    JE ZF_ZERO

    MOV DL, '1'
    JMP PRINT_ZF

ZF_ZERO:
    MOV DL, '0'

PRINT_ZF:
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_DIGIT PROC
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    RET
PRINT_DIGIT ENDP

END MAIN
