; Date: 20/01/2019
; Control.asm
; Author: Daniele Votta
; Description: Control Operations.
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
	
	jmp Begin		; (Unconditional Jump)

NeverExecute:			; This code is never executed
	mov eax,0x10
	xor ebx,ebx

Begin:
	mov eax,0x5		; counter for loop = 5

PrintHW:
	push eax		; Save counter in stack
	
	; Print Message
        mov eax,0x4             ; 4 -> FC for write
        mov ebx,1               ; stdin=0, stdout=1, stderr=2
        mov ecx,message         ; message
        mov edx,mlen            ; length
        int 0x80                ; syscall

	pop eax			; Load counter from stack
	dec eax			; decrement counter | -1
	jnz PrintHW		; (Conditional Jump) jump to PrintHW if eax is not 0 | equal to jne -> Typically used after cmp

	; Exit Gracefully
        mov eax,0x1             ; 1 -> FC for exit
        mov ebx,0x0     	; return value
        int 0x80        	; syscall

section .data
	
	message: db "Hello World!", 0xa
        mlen equ $-message
