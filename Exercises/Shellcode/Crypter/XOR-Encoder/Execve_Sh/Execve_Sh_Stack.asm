; Date: 28/01/2019
; Execve_Sh_Stack.asm
; Author: Daniele Votta
; Description: This program invoke excve.
; JMP | CALL | POP | Techniques
;
; SYNOPSIS
;      #include <unistd.h>
;      int execve(const char *filename, char *const argv[], char *const envp[]);
;
; filename -> /bin/sh, 0x0 -> EBX
; argv[] -> Address of /bin/sh, 0x00000000 -> ECX
; envp[] -> 0x00000000 -> EDX

; section wtext exec write | to make the .text section writable | Otherwise pass -N to the linker

global _start

section .text

_start:

	; int execve(const char *filename, char *const argv[], char *const envp[]);
	
	xor eax,eax			; Push the first null
	push eax			; 0s - 1st parameter 0x00000000

	; push /bin//sh (8 bytes)	; 1st parameter /bin//sh
	push 0x68732f2f			; hs//
	push 0x6e69622f			; nib/

	mov ebx,esp	 		; 2nd parameter - point to /bin//sh0x00000000 (/bin//sh null terminated must be in ebx)
	push eax			; 0s 
	mov edx,esp			; align esp to edx

	push ebx			; 3rd parameter - point to /bin//sh0x00000000
	mov ecx,esp			; mov top of the stack to ecx

	mov al,11
	int 0x80			; syscall	

