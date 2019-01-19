; Date: 19/01/2019
; Stack.asm
; Author: Daniele Votta
; Description: Stack Operations.
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:
       
	mov eax,0x66778899
	mov ebx,0x0
	mov ecx,0x0

	; push and pop of t/m16 and r/m32
	; register push and pop

	push ax
	pop bx

	push eax
	pop ecx

	; memory push and pop

	push word[sample]
	pop ecx

	push dword[sample]
	pop edx

	; Exit Gracefully
        mov eax,0x1             	; 1 -> FC for exit
        mov ebx,0x0             	; return value
        int 0x80                	; syscall

section .data
	sample: db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x12


