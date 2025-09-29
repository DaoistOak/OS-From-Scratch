org 0x7E00      ; matches jump target in boot.asm
bits 16

start_kernel:
    mov si, message
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

message db 'Hello from kernel!', 0
