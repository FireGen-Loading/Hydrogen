[bits 16]
[org 0x7c00]
jmp boot

BOOT_DISK: db 0
KERNEL_ADDRESS equ 0x1000 
CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ  data_descriptor - GDT_Start

GDT_Start:
    null_desc:
        dd 0
        dd 0
    code_descriptor:
        dw 0xffff
        dw 0                ; 16 bits
        db 0                ; + 8 bits
        db 0b10011010       ; 4bits  Flags(1bit present, 2bit Privilage, 1bit type)  4bits Type Flags(Code?, Conforming? Readable?, Accessed?)
        db 0b11001111       ; 4bits other Flags(Granularity, 32 bit?, 64 bits?, AVL) 4bits other
        db 0
    data_descriptor:
        dw 0xffff
        dw 0                ; 16 bits
        db 0                ; + 8 bits
        db 0b10010010       ; 4bits  Flags(1bit present, 2bit Privilage, 1bit type)  4bits Type Flags(Code?, direction? Writeable?, Accessed?)
        db 0b11001111       ; 4bits other Flags(Granularity, 32 bit?, 64 bits?, AVL) 4bits other
        db 0
GDT_End:
GDT_descriptor:
    dw GDT_End - GDT_Start - 1
    dd GDT_Start 

; VARIABLE TABLE ↑
; CODE ↓

boot:
    mov [BOOT_DISK], dl
    ; CHD(Cylinder Head Disk)
    mov bx, 0
    mov es, bx                  ; segemant offset 
    mov bx, KERNEL_ADDRESS      ; Load to

    mov ah, 2                   ; Bios command code
    mov al, 15                  ; Sectors to load
    mov dl, [BOOT_DISK]        ; Disk
    mov ch, 0                   ; Cylinder
    mov dh, 0                   ; Head
    mov cl, 2                   ; Sector
    int 0x13                 
        ; Load kernel

    mov ah, 0x0
    mov al, 0x3
    int 0x10
        ; clear screen

    cli
    lgdt [GDT_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
        ; enter 32 bit mode
    jmp CODE_SEG:BIT32MODE

[bits 32]
BIT32MODE:
mov ax, DATA_SEG
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov ebp,0x90000
mov esp, ebp

jmp KERNEL_ADDRESS

times 510-($-$$) db 0
dw 0xaa55