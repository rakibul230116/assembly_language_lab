; Problem 25: Concatenate two strings
.MODEL SMALL
.STACK 100H
.DATA
    STR1 DB 'Hello $'
    STR2 DB 'World!$'
    MSG DB 13,10,'Combined string: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA SI, STR1
FIND_END:
    CMP BYTE PTR [SI], '$'
    JE APPEND
    INC SI
    JMP FIND_END
APPEND:
    MOV BYTE PTR [SI], ' '
    INC SI
    LEA DI, STR2
COPY_LOOP:
    MOV AL, [DI]
    MOV [SI], AL
    INC SI
    INC DI
    CMP AL, '$'
    JNE COPY_LOOP

    LEA DX, MSG
    MOV AH, 09H
    INT 21H
    LEA DX, STR1
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
