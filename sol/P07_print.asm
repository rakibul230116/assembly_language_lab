TITLE PGM7: PRINT A STRING
; CSE 3210 Lab Problem 07 - style of Yu & Marut (Assembly Language Programming)
.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
MSG DB 'Assembly Language Programming',0DH,0AH,'CSE 3210 Lab$'
.CODE
MAIN PROC
; initialize DS
 MOV AX,@DATA
 MOV DS,AX
 LEA DX,MSG
 MOV AH,9
 INT 21H
; DOS exit
 MOV AH,4CH
 INT 21H
MAIN ENDP
END MAIN
