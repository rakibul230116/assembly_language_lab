
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.MODEL SMALL
.STACK 100H
.DATA
  MSG DB 'ENTER A CHAR:$'
  MSG2 DB 13,10, 'YOU ENTERED:$'
  
.CODE
 MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,09H
    LEA DX,MSG
    INT 21H
    
    MOV AH,01H
    INT 21H
    MOV BL,AL 
    
    MOV AH,09H
    LEA DX,MSG2
    INT 21H 
    
    MOV DL,BL
    MOV AH,02H
    INT 21H
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
END MAIN
    
      

ret




