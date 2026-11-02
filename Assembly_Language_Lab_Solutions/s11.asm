
; Q8: Calculate ((A * B) + C) / D
; Display one decimal digit on common-cathode 7-segment
; 8255: Port A = 00H, Control = 06H

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter A (0-9): $'
    MSG2 DB 13,10,'Enter B (0-9): $'
    MSG3 DB 13,10,'Enter C (0-9): $'
    MSG4 DB 13,10,'Enter D (1-9): $'
    MSG5 DB 13,10,'Result = $'

    A DB ?
    B DB ?
    C DB ?
    D DB ?
    RESULT DB ?

    ; Common-cathode 7-segment codes
    ; Bit order: DP-G-F-E-D-C-B-A
    SEGTAB DB 3FH,06H,5BH,4FH,66H
           DB 6DH,7DH,07H,7FH,6FH

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input A
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    CALL READ_DIGIT
    MOV A, AL

    ; Input B
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    CALL READ_DIGIT
    MOV B, AL

    ; Input C
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    CALL READ_DIGIT
    MOV C, AL

    ; Input D
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H
    CALL READ_DIGIT
    MOV D, AL

    ; Calculate A * B
    MOV AL, A
    MUL B

    ; Add C
    ADD AL, C
    ADC AH, 00H

    ; Divide by D
    CMP D, 00H
    JE EXIT_PROGRAM

    DIV D
    MOV RESULT, AL

    ; Display result on DOS screen
    LEA DX, MSG5
    MOV AH, 09H
    INT 21H

    MOV DL, RESULT
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Configure 8255
    MOV AL, 80H
    OUT 06H, AL

    ; Send seven-segment pattern
    MOV BX, OFFSET SEGTAB
    MOV AL, RESULT
    CMP AL, 09H
    JA EXIT_PROGRAM

    XLAT
    OUT 00H, AL

EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Read one decimal digit
READ_DIGIT PROC
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    RET
READ_DIGIT ENDP

END MAIN
