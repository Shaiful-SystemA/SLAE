; Date: 26/01/2019
; HelloWorldShellcode.asm
; Author: Daniele Votta
; Description: This program prints "Hello World!" on the screen. Creating shellcode without nulls.
; JMP | CALL | POP | Techniques
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

jmp short Call_Shellcode

Shellcode:

        ; Print Message
	xor eax,eax
        mov al,0x4              ; 4 -> FC for write
	xor ebx,ebx
        mov bl,1                ; stdin=0, stdout=1, stderr=2  
	pop ecx                 ; retreive the address of message from the stack
	xor edx,edx
        mov dl,13           	; length
        int 0x80                ; syscall
   
      ; Exit Gracefully
	xor eax, eax
	inc eax
        int 0x80                ; syscall

Call_Shellcode:
	call Shellcode			; save the address of message in stack
	message: db "Hello World!", 0xa

section .data


