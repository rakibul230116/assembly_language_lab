TITLE PGM12: UPPERCASE LETTER DISPLAY (AND CONDITION)
; CSE 3210 Lab Problem 12 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
P1 DB 'Enter a character: $'
P2 DB 0DH,0AH,'Uppercase letter: $'
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,P1
 MOV AH,9
 INT 21H
 MOV AH,1
 INT 21H
 MOV BL,AL
 CMP BL,'A'        ; condition 1: BL >= 'A'
 JB QUIT
 CMP BL,'Z'        ; condition 2: BL <= 'Z'
 JA QUIT
 LEA DX,P2
 MOV AH,9
 INT 21H
 MOV AH,2
 MOV DL,BL
 INT 21H
QUIT:
; DOS exit
 MOV AH,4CH
 INT 21H
MAIN ENDP
END MAIN
