; Date: 20/01/2019
; Libc.asm
; Author: Daniele Votta
; Description: Libc function.
;
; Using libc instead of syscall
;
; SYNOPSIS
; #include <stdio.h>
; int printf(const char *format, ...);
;
; SYNOPSIS
; #include <unistd.h>
; void _exit(int status);

extern printf
extern exit


global main:
section .text

main:
	push message	; it is the pointer to message into stack
	call printf	; require 1 argument -> message
	add esp,0x4	; adjust the stack

	mov eax,0x0	; return value
	call exit	; require 1 argument -> return value

section .data
	
	message: db "Hello World!", 0xa, 0x0 	; null terminated
        mlen equ $-message
