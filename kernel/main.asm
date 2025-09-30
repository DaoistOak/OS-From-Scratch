; kernel/main.asm
org 0x7E00
bits 16

start:
    mov si, msg
    call print_string
    cli
.halt:
    hlt
    jmp .halt

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

msg db 'Hello from kernel', 0

times 512-($-$$) db 0  ; pad kernel to 1 sector

