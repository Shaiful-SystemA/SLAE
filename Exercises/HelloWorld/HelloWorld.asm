; Date: 12/01/2019
; HelloWorld.asm
; Author: Daniele Votta
; Description: This program prints "Hello World!" on the screen.
;
; cat /usr/include/i386-linux-gnu/asm/unistd_32.h 
; Write: FC 4 - SYNOPSIS
;       #include <unistd.h>
;       ssize_t write(int fd, const void *buf, size_t count);
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:
        ; Print Message
        mov eax,0x4             ; 4 -> FC for write
        mov ebx,1               ; stdin=0, stdout=1, stderr=2
        mov ecx,message         ; message
        mov edx,mlen            ; length
        int 0x80                ; syscall
        ; Exit Gracefully
        mov eax,0x1             ; 1 -> FC for exit
        mov ebx,0x5             ; return value
        int 0x80                ; syscall

section .data
        message: db "Hello World!", 0xa
        mlen equ $-message
