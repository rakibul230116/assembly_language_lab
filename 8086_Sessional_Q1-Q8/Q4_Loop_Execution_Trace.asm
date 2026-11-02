; Q4: Add CX to AX for five loop iterations
; Display final AX value

.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'Final AX = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 0005H
    MOV AX, 0000H

L1:
    ADD AX, CX
    LOOP L1

    ; Display message
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Display AX in hexadecimal
    MOV BX, AX
    MOV CL, 4

    MOV DL, BH
    SHR DL, CL
    CALL PRINT_HEX

    MOV DL, BH
    AND DL, 0FH
    CALL PRINT_HEX

    MOV DL, BL
    SHR DL, CL
    CALL PRINT_HEX

    MOV DL, BL
    AND DL, 0FH
    CALL PRINT_HEX

    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Print one hexadecimal digit
PRINT_HEX PROC
    CMP DL, 09H
    JBE NUMBER

    ADD DL, 37H
    JMP DISPLAY

NUMBER:
    ADD DL, 30H

DISPLAY:
    MOV AH, 02H
    INT 21H
    RET
PRINT_HEX ENDP

END MAIN