8086 ASSEMBLY LANGUAGE LAB - EASY SOLUTIONS
============================================

Course: CSE 3210 - Microprocessor and Assembly Language

All programs are written in simple MASM/TASM 8086 DOS style.

FILES
-----
01_8086_Architecture_and_Emulator.txt
    Basic 8086 architecture, registers, flags, memory and emulator notes.

02_Hello_World.asm
    Prints Hello World.

03_Input_Two_Numbers_Print.asm
    Inputs two single-digit numbers and prints them.

04_All_Operations.asm
    Demonstrates MOV, XCHG, ADD, SUB, INC, DEC and NEG.

05_Sum_of_Two_Numbers.asm
    Inputs two single-digit numbers and calculates their sum.

06_Read_Character_Display_Next_Line.asm
    Reads one character and displays it at the beginning of the next line.

07_Print_a_String.asm
    Prints a string.

08_Lowercase_to_Uppercase.asm
    Converts one lowercase letter to uppercase.

09_Display_Flags.asm
    Performs FFFFH + 0001H and displays Carry Flag and Zero Flag.

10_Display_IBM_Instruction_Character_Set.asm
    Displays printable ASCII/IBM-style character set using a jump loop.

11_Absolute_Value_of_AX.asm
    Converts the number in AX to its absolute value using branching.

HOW TO RUN
----------
Option 1: EMU8086
1. Open EMU8086.
2. Create/open an .ASM file.
3. Paste/open the required program.
4. Compile/Emulate.
5. Run and observe the output.

Option 2: MASM/TASM + DOSBox
1. Put the .ASM files in your DOSBox working folder.
2. Assemble:
       MASM filename.asm;
3. Link:
       LINK filename.obj;
4. Run:
       filename.exe

IMPORTANT
---------
These are beginner-friendly versions. Most input examples use a single
digit because that keeps the 8086 code easy to understand.

DOS INT 21H FUNCTIONS USED
--------------------------
AH=01H : Read one character from keyboard (also echoes it)
AH=02H : Display one character in DL
AH=09H : Display a $-terminated string at DS:DX
AH=4CH : Exit to DOS

COMMON PROGRAM STRUCTURE
------------------------
.MODEL SMALL
.STACK 100H
.DATA
    ; variables/messages
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; program instructions

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
