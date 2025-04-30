org 0x7C00
bits 16

start:
    mov si, message
    call print_string
    jmp $

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

message db 'Hello, World!', 0

times 510-($-$$) db 0
dw 0xAA55
