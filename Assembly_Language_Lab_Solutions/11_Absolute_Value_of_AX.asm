; Problem 11: Replace the number in AX by its absolute value
; Uses branching instructions.
; Example: AX = -25 -> AX becomes +25.

.MODEL SMALL
.STACK 100H

.DATA
NUM DW -25
MSG DB 'Absolute value is: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, NUM

    ; If AX is negative, negate it
    CMP AX, 0
    JGE POSITIVE

    NEG AX

POSITIVE:
    PUSH AX

    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    POP AX

    ; Print AX as unsigned decimal
    CALL PRINT_NUM

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; ------------------------------------------
; PRINT_NUM: prints unsigned number in AX
; ------------------------------------------
PRINT_NUM PROC
    CMP AX, 0
    JNE CONVERT

    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    RET

CONVERT:
    MOV BX, 10
    XOR CX, CX

DIVIDE:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIVIDE

DISPLAY:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY

    RET
PRINT_NUM ENDP

END MAIN
