; Problem 20
; Reverse all 8 bits of AL.
; Example: AL = 10010000B -> result = 00001001B.
; The loop takes the least-significant bit of AL and builds
; the reversed value in BL.

.MODEL SMALL
.STACK 100H
.DATA
    number DB 90H         ; 10010000B

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, number
    XOR BL, BL            ; BL = 00000000
    MOV CX, 8

REVERSE_LOOP:
    SHR AL, 1             ; LSB of AL goes into Carry Flag
    RCL BL, 1             ; Carry enters BL from the right
    LOOP REVERSE_LOOP

    ; Reversed 8-bit value is now in BL
    ; For 90H (10010000B), BL = 09H (00001001B)

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
