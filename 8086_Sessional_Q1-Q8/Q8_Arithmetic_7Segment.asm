; Q8: Result = ((A * B) + C) / D, then show one digit
; Hardware assumptions:
; 8255 Port A = 00H, control register = 06H
; Port A drives one common-cathode 7-segment digit.
; Change port addresses to match your trainer kit.
.MODEL SMALL
.STACK 100H
.DATA
    A      DB 02H
    B      DB 03H
    C      DB 04H
    D      DB 02H
    RESULT DB ?

    ; Common-cathode codes, bit order DP-G-F-E-D-C-B-A
    SEGTAB DB 3FH, 06H, 5BH, 4FH, 66H
           DB 6DH, 7DH, 07H, 7FH, 6FH
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, A
    MUL B              ; AX = A * B
    ADD AL, C          ; Sample: 06H + 04H = 0AH
    ADC AH, 00H        ; Preserve carry into high byte

    ; Divide 16-bit AX by byte D.
    DIV D              ; Quotient in AL, remainder in AH
    MOV RESULT, AL     ; Sample result = 05H

    ; Configure 8255: mode 0, all ports output (example address)
    MOV AL, 80H
    OUT 06H, AL

    ; Convert decimal digit 0..9 to 7-segment pattern
    MOV BX, OFFSET SEGTAB
    MOV AL, RESULT
    XLAT
    OUT 00H, AL        ; Send pattern 6DH for digit 5

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
