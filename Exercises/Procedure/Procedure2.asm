; Date: 20/01/2019
; Procedure2.asm
; Author: Daniele Votta
; Description: Procedures - Preserve ebp, registers and flags.
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
	
HelloWorldProc:

	push ebp
	mov ebp,esp
	
	; Print Message
        mov eax,0x4             ; 4 -> FC for write
        mov ebx,1               ; stdin=0, stdout=1, stderr=2
        mov ecx,message         ; message
        mov edx,mlen            ; length
        int 0x80                ; syscall

	; mov esp,ebp
	; pop ebp
	
	leave
	ret			; Return | eip popped from the stack

_start:

	mov ecx,0x10		; Loop Counter -> 10hex = 16dec | 16 times

PrintHelloWorld:

	; preserve registers and flags

	pushad
	pushfd
	call HelloWorldProc	; Call procedure -> HelloWorldProc | eip pushed automaticallly to the stack

	; restore registers and stack

	popfd
	popad

	loop PrintHelloWorld	; (Loop) jump to PrintHelloWorld if ecx is not 0 | automatically decrement ecx (not require dec ecx)

	; Exit Gracefully
        mov eax,0x1             ; 1 -> FC for exit
        mov ebx,0x0     	; return value
        int 0x80        	; syscall

section .data
	
	message: db "Hello World!", 0xa
        mlen equ $-message
