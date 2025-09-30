org 0x7C00
bits 16
start:
    ; Print bootloader message
    mov si, bootmsg
    call print_string

    ; Load kernel (second sector) at 0x7E00
    mov ah, 0x02      ; read sector
    mov al, 1         ; number of sectors
    mov ch, 0         ; cylinder
    mov cl, 2         ; sector (kernel starts here)
    mov dh, 0         ; head
    ; DL already contains boot drive from BIOS, don't overwrite it!
    mov ax, 0x07E0
    mov es, ax
    xor bx, bx
    int 0x13
    jc disk_error

    jmp 0x07E0:0x0000

disk_error:
    mov si, errmsg
    call print_string
    jmp $

; --- Print routine ---
print_string:
    mov ah, 0x0E
.repeat:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .repeat
.done:
    ret

bootmsg db 'Bootloader running...', 0
errmsg  db 'Disk read error', 0

times 510-($-$$) db 0
dw 0xAA55

