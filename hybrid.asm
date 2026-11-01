org 100h

.model small
.stack 100h

.data
THRESHOLD equ 4
MAXN      equ 20

arr   dw MAXN dup(?)
tmp   dw MAXN dup(?)
count dw ?

m_mid   dw ?
m_right dw ?

msg_n      db 13,10,'Enter N (1-20): $'
msg_in     db 'Enter number: $'
msg_before db 13,10,'Before: $'
msg_after  db 13,10,'After : $'

.code
main proc
    mov ax, @data
    mov ds, ax

ask_n:
    lea dx, msg_n
    mov ah, 9
    int 21h
    call read_num
    call newline
    cmp ax, 1
    jb  ask_n
    cmp ax, MAXN
    ja  ask_n
    mov count, ax

    mov cx, ax
    xor bx, bx
in_loop:
    lea dx, msg_in
    mov ah, 9
    int 21h
    call read_num
    mov arr[bx], ax
    add bx, 2
    call newline
    loop in_loop

    lea dx, msg_before
    mov ah, 9
    int 21h
    call print_array

    xor si, si              ; left = 0
    mov di, count
    dec di                  ; right = N-1
    call hybrid_sort

    lea dx, msg_after
    mov ah, 9
    int 21h
    call print_array

    mov ah, 4Ch
    int 21h
main endp

; ---------------------------------------------------
; read_num: keyboard theke number pore (Enter porjonto), AX = result
; ---------------------------------------------------
read_num proc
    push bx
    push cx
    push dx
    xor bx, bx
rn_loop:
    mov ah, 1
    int 21h
    cmp al, 13
    je  rn_done
    cmp al, '0'
    jb  rn_loop
    cmp al, '9'
    ja  rn_loop
    sub al, '0'
    xor ah, ah
    mov cx, ax              ; digit
    mov ax, bx
    mov dx, 10
    mul dx                  ; ax = bx*10
    add ax, cx
    mov bx, ax
    jmp rn_loop
rn_done:
    mov ax, bx
    pop dx
    pop cx
    pop bx
    ret
read_num endp

newline proc
    push ax
    push dx
    mov dl, 13
    mov ah, 2
    int 21h
    mov dl, 10
    int 21h
    pop dx
    pop ax
    ret
newline endp

; ---------------------------------------------------
; bubble_sort: SI = left, DI = right (index, inclusive)
; ---------------------------------------------------
bubble_sort proc
    push ax
    push bx
    push cx
    push dx

    mov cx, di
    sub cx, si              ; cx = passes baki
    jle bs_done
bs_outer:
    push cx
    mov bx, si
    shl bx, 1               ; byte offset of left
    xor dx, dx              ; swapped = 0
bs_inner:
    mov ax, arr[bx]
    cmp ax, arr[bx+2]
    jle bs_next
    xchg ax, arr[bx+2]      ; swap
    mov arr[bx], ax
    mov dx, 1
bs_next:
    add bx, 2
    loop bs_inner
    pop cx
    cmp dx, 0               ; swap na hole early exit
    je bs_done
    dec cx
    jnz bs_outer
bs_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
bubble_sort endp

; ---------------------------------------------------
; merge: SI = left, BX = mid, DI = right (index)
; ---------------------------------------------------
merge proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    shl bx, 1
    mov m_mid, bx           ; mid * 2 (byte offset)
    shl di, 1
    mov m_right, di         ; right * 2
    shl si, 1               ; left * 2

    ; arr[left..right] -> tmp
    mov cx, di
    sub cx, si
    shr cx, 1
    inc cx                  ; element count
    mov bx, si
cp_loop:
    mov ax, arr[bx]
    mov tmp[bx], ax
    add bx, 2
    loop cp_loop

    ; SI = i, DI = j, BX = k
    mov bx, si
    mov di, m_mid
    add di, 2
mg_loop:
    cmp si, m_mid
    jg  mg_done
    cmp di, m_right
    jg  mg_rest_left
    mov ax, tmp[si]
    mov dx, tmp[di]
    cmp ax, dx
    jg  mg_take_right
    mov arr[bx], ax
    add si, 2
    add bx, 2
    jmp mg_loop
mg_take_right:
    mov arr[bx], dx
    add di, 2
    add bx, 2
    jmp mg_loop
mg_rest_left:
    cmp si, m_mid
    jg  mg_done
    mov ax, tmp[si]
    mov arr[bx], ax
    add si, 2
    add bx, 2
    jmp mg_rest_left
mg_done:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
merge endp

; ---------------------------------------------------
; hybrid_sort: SI = left, DI = right (index, inclusive)
; ---------------------------------------------------
hybrid_sort proc
    cmp si, di
    jge hs_ret

    mov ax, di
    sub ax, si
    inc ax                  ; size
    cmp ax, THRESHOLD
    jg  hs_split
    call bubble_sort
    ret

hs_split:
    push bp
    push si                 ; [bp+4] = left
    push di                 ; [bp+2] = right
    mov bx, si
    add bx, di
    shr bx, 1               ; mid
    push bx                 ; [bp]   = mid
    mov bp, sp

    mov di, bx
    call hybrid_sort        ; left half

    mov bx, [bp]
    mov di, [bp+2]
    mov si, bx
    inc si
    call hybrid_sort        ; right half

    mov bx, [bp]
    mov si, [bp+4]
    mov di, [bp+2]

    push bx                 ; already sorted hole merge skip
    shl bx, 1
    mov ax, arr[bx]
    cmp ax, arr[bx+2]
    pop bx
    jle hs_pop

    call merge
hs_pop:
    pop bx
    pop di
    pop si
    pop bp
hs_ret:
    ret
hybrid_sort endp

; ---------------------------------------------------
; print_num: AX = unsigned number, print kore + space
; ---------------------------------------------------
print_num proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10
    xor cx, cx
pn_div:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz pn_div
pn_out:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop pn_out

    mov dl, ' '
    mov ah, 2
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp

print_array proc
    push ax
    push bx
    push cx
    xor bx, bx
    mov cx, count
pa_loop:
    mov ax, arr[bx]
    call print_num
    add bx, 2
    loop pa_loop
    pop cx
    pop bx
    pop ax
    ret
print_array endp

end main