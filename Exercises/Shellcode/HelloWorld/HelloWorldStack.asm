; Date: 26/01/2019
; HelloWorldShellcodeStack.asm
; Author: Daniele Votta
; Description: This program prints "Hello World!" on the screen. Creating shellcode without nulls.
; PUSH and refer ESP Techniques
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
	xor eax,eax
        mov al,0x4              ; 4 -> FC for write
	xor ebx,ebx
        mov bl,1                ; stdin=0, stdout=1, stderr=2  
	
	xor edx,edx
	push edx		; push 0s on the stack

	push 0x0a21646c		; message 'Hello World!\n' | code[::-1] '\n!dlroW olleH' | code[::-1].encode('hex') '0a21646c726f57206f6c6c6548'
	push 0x726f5720		; message
	push 0x6f6c6c65		; message
	push 0x48		; message

	mov ecx,esp		; retreive the address of message from the stack referring the top of the stack | esp
        
	mov dl,16	      	; length
        int 0x80                ; syscall
   
      ; Exit Gracefully
	xor eax, eax
	inc eax
        int 0x80                ; syscall

section .data


