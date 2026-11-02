; Q2: Reverse HELLO using SI, DI, LODSB and STOSB
.MODEL SMALL
.STACK 100H
.DATA
    STR1 DB 'HELLO'
    STR2 DB 5 DUP(?)
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    LEA SI, STR1
    ADD SI, 4          ; SI points to last character
    LEA DI, STR2
    MOV CX, 5

L1:
    STD                ; LODSB decrements SI
    LODSB              ; AL = DS:[SI], then SI = SI - 1
    CLD                ; STOSB must increment DI
    STOSB              ; ES:[DI] = AL, then DI = DI + 1
    LOOP L1

    ; STR2 now contains OLLEH (5 bytes, not '$'-terminated)
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
