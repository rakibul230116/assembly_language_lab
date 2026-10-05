8086 Assembly Problems 12-20
==============================

These files are written in MASM/TASM/EMU8086-compatible 8086 DOS assembly syntax.

Files:
12  problem12_uppercase_and.asm
13  problem13_y_or_Y.asm
14  problem14_invert_16bit.asm
15  problem15_lower_to_upper.asm
16  problem16_ascii_digit_to_value.asm
17  problem17_multiply_ax_by_2_shift.asm
18  problem18_divide_bx_by_8.asm
19  problem19_rotate_bx_left_4.asm
20  problem20_reverse_8_bits.asm

How to run in EMU8086:
1. Open the .asm file.
2. Compile/Assemble it.
3. Run it.
4. For Problems 14 and 17-20, inspect the specified register/memory value in the emulator debugger.

Important:
- Problem 14 result is stored in memory variable 'number' and loaded into AX.
- Problem 17 result is in AX.
- Problem 18 result is in BX.
- Problem 19 result is in BX.
- Problem 20 result is in BL.

Sample results:
P14: number = 1234H -> ED CB H (EDCBH)
P17: AX = 0015H -> 002AH
P18: BX = 0064H -> 000CH (100 / 8 = 12)
P19: BX = 1234H -> 2341H
P20: AL = 90H (10010000B) -> BL = 09H (00001001B)
