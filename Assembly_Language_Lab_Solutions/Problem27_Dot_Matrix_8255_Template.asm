; Problem 27: 8x8 dot-matrix - illustrative 8255 hardware template
; Assumptions only: Port A=00h, Port B=02h, Control=06h.
; Actual port addresses, polarity and wiring depend on your kit.
; Real displays generally need repeated row scanning/multiplexing.
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV DX, 06H
    MOV AL, 80H
    OUT DX, AL                  ; 8255 Mode 0, ports output (example)

    MOV SI, OFFSET PATTERN
    MOV CX, 8
DISPLAY_ROW:
    MOV AX, 8
    SUB AX, CX
    MOV DX, 02H
    OUT DX, AL                  ; row select (example)

    MOV AL, [SI]
    MOV DX, 00H
    OUT DX, AL                  ; column bitmap (example)

    INC SI
    LOOP DISPLAY_ROW

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PATTERN DB 18H, 3CH, 7EH, 0FFH, 18H, 18H, 18H, 18H
END MAIN
