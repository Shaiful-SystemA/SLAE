; Date: 20/01/2019
; Loop.asm
; Author: Daniele Votta
; Description: Loop Operations.
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
	mov ecx,0x5		; counter for loop = 5

PrintHW:
	push ecx		; Save counter in stack
	
	; Print Message
        mov eax,0x4             ; 4 -> FC for write
        mov ebx,1               ; stdin=0, stdout=1, stderr=2
        mov ecx,message         ; message
        mov edx,mlen            ; length
        int 0x80                ; syscall

	pop ecx			; Load counter from stack
	loop PrintHW		; (Loop) jump to PrintHW if ecx is not 0 | automatically decrement ecx (not require dec ecx)

	; Exit Gracefully
        mov eax,0x1             ; 1 -> FC for exit
        mov ebx,0x0     	; return value
        int 0x80        	; syscall

section .data
	
	message: db "Hello World!"
        mlen equ $-message
