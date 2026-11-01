
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
                     
.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 'Hello World$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN                     
ret




