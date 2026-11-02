; Q1: Find Maximum Number from 5 User Inputs
; Input: 5 unsigned hexadecimal numbers (00-FF)
; Output: Maximum number

.MODEL SMALL
.STACK 100H

.DATA
    ARRAY DB 5 DUP(?)

    MSG1 DB 'Enter 5 hexadecimal numbers (00-FF):',13,10,'$'
    MSG2 DB 13,10,'Maximum Number = $'
    NL   DB 13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display input message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Input 5 hexadecimal numbers
    LEA SI, ARRAY
    MOV CX, 5

INPUT_LOOP:
    CALL READ_HEX_BYTE
    MOV [SI], AL

    INC SI
    LOOP INPUT_LOOP

    ; Find maximum number
    LEA SI, ARRAY
    MOV AL, [SI]

    INC SI
    MOV CX, 4

MAX_LOOP:
    CMP AL, [SI]
    JAE SKIP

    MOV AL, [SI]

SKIP:
    INC SI
    LOOP MAX_LOOP

    ; Display result message
    PUSH AX
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    POP AX

    ; Display maximum in hexadecimal
    CALL PRINT_HEX_BYTE

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP


;--------------------------------
; Read one hexadecimal byte
;--------------------------------
READ_HEX_BYTE PROC

    PUSH BX

    ; Read first digit
    CALL READ_HEX_DIGIT

    MOV BL, AL
    SHL BL, 1
    SHL BL, 1
    SHL BL, 1
    SHL BL, 1

    ; Read second digit
    CALL READ_HEX_DIGIT

    OR AL, BL

    POP BX
    RET

READ_HEX_BYTE ENDP


;--------------------------------
; Read one hexadecimal digit
;--------------------------------
READ_HEX_DIGIT PROC

    MOV AH, 01H
    INT 21H

    CMP AL, '9'
    JBE DIGIT

    SUB AL, 37H
    RET

DIGIT:
    SUB AL, 30H
    RET

READ_HEX_DIGIT ENDP


;--------------------------------
; Display AL as hexadecimal
;--------------------------------
PRINT_HEX_BYTE PROC

    PUSH AX
    PUSH BX

    MOV BL, AL

    ; Print upper digit
    MOV DL, BL
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1

    CALL PRINT_HEX_DIGIT

    ; Print lower digit
    MOV DL, BL
    AND DL, 0FH

    CALL PRINT_HEX_DIGIT

    POP BX
    POP AX
    RET

PRINT_HEX_BYTE ENDP


;--------------------------------
; Display one hexadecimal digit
;--------------------------------
PRINT_HEX_DIGIT PROC

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

PRINT_HEX_DIGIT ENDP

END MAIN