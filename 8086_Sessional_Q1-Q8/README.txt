8086 Microprocessor and Assembly Language Sessional - Q1 to Q8

Files:
Q1_Maximum_Array.asm          Find maximum unsigned byte using SI and LOOP.
Q2_String_Reverse.asm         Reverse HELLO using SI, DI, LODSB and STOSB.
Q3_Address_Calculation.asm    Calculate EA, physical address and final AX.
Q4_Loop_Execution_Trace.asm   Trace LOOP and find final AX.
Q5_Sum_Even_Array.asm         Sum even array elements using TEST/JNZ/LOOP.
Q6_Factorial_Procedure.asm    Factorial using procedure, CALL/RET, PUSH/POP.
Q7_Count_Set_Bits.asm         Count set bits using ROR and carry flag.
Q8_Arithmetic_7Segment.asm   Arithmetic expression and common-cathode lookup.

Expected sample answers:
Q1: MAX = 67H
Q2: STR2 = OLLEH
Q3: EA = 0120H, physical address = 20120H, AX = 1244H
Q4: AX = 000FH
Q5: SUM = 0010H
Q6: RESULT = 0018H (24 decimal)
Q7: COUNT = 04H
Q8: RESULT = 05H; common-cathode pattern = 6DH

Important notes:
1. These are MASM/EMU8086-style source files. Assemble/run each program separately.
2. Q1, Q2, Q5, Q6 and Q7 store results in memory variables. They do not print
   text to the emulator screen. Inspect the variables in the emulator's memory
   or debugger after execution.
3. Q3 assumes the word 1234H is already stored at DS:0120H. To run it, initialize
   that memory location in the emulator/debugger, or adapt the program to write
   1234H there before reading it.
4. Q2 uses STD for LODSB to move SI backward, then CLD before STOSB so DI moves
   forward. The direction flag is clear after each iteration.
5. Q8 uses example 8255 I/O addresses (Port A 00H, control 06H). Your physical
   trainer kit may use different addresses and wiring. This example is for a
   single common-cathode digit, not a multiplexed display.
6. Q8 is intended for a real 8086/8255 trainer with I/O port access. It will not
   drive a physical display in ordinary EMU8086 software simulation unless the
   simulator supports the configured hardware ports.

Register trace answers:
Q3: DS=2000H, BX=0100H, SI=0020H, EA=0120H, PA=20120H, AX final=1244H.
Q4: AX progression = 0005H, 0009H, 000CH, 000EH, 000FH.
Q5: Even values = 02H + 08H + 06H = 10H.
Q6: 4 * 3 * 2 * 1 = 24 decimal = 18H.
Q7: 5AH = 01011010B, which contains four 1 bits.
Q8: ((02H * 03H) + 04H) / 02H = 05H.
