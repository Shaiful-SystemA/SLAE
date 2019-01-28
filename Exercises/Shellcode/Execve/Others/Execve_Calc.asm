; Date: 27/01/2019
; Execve_Calc.asm
; Author: Daniele Votta
; Description: This program invoke excve to run terminal calculator (bc).
; JMP | CALL | POP | Techniques
;
; SYNOPSIS
;      #include <unistd.h>
;      int execve(const char *filename, char *const argv[], char *const envp[]);
;
; filename -> /bin/bash, 0x0 -> EBX
; argv[] -> Address of /usr/bin/bc, 0x00000000 -> ECX
; envp[] -> 0x00000000 -> EDX
; Structure like this -> /usr/bin/bc|A|BBBB|CCCC

; section wtext exec write | to make the .text section writable | Otherwise pass -N to the linker

global _start

section .text

_start:
	jmp short call_shellcode

shellcode:
	
	; Manipulate message
	pop esi			; contains the address of message
	xor ebx,ebx		; 0s
	mov byte[esi+11],bl	; Convert "A" to 0x0 -> the 9 byte in message -> "/usr/bin/bcABBBBCCCC" -> A become 0
	mov dword[esi+12],esi   ; store the address of esi -> /usr/bin/bc0x0
	mov dword [esi+16],ebx  ; Convert "BBBB" to 0x00000000
        
	; Call Execve | int execve(const char *filename, char *const argv[], char *const envp[]);
	lea ebx,[esi]		
	lea ecx,[esi+12]
	lea edx,[esi+16]
	xor eax,eax
	mov al,11		; execve FC->11
        int 0x80                ; syscall

call_shellcode:
	call shellcode
	message db "/usr/bin/bcABBBBCCCC"
