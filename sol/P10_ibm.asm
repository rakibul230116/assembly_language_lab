TITLE PGM10: IBM CHARACTER SET USING JUMP INSTRUCTIONS
; CSE 3210 Lab Problem 10 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 MOV AH,2          ; display char function
 MOV CX,256        ; no. of chars to display
 MOV DL,0          ; DL has ASCII code of null char
PRINT_LOOP:
 INT 21H           ; display a char
 INC DL            ; increment ASCII code
 DEC CX            ; decrement counter
 JNZ PRINT_LOOP    ; keep going if CX not 0
; DOS exit
 MOV AH,4CH
 INT 21H
MAIN ENDP
END MAIN
