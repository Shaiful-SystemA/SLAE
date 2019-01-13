; Date: 13/01/2019
; MovingData.asm
; Author: Daniele Votta
; Description: Moving Data.
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:
        ; Move immediate data to register
	mov eax,0xaaaaaaaa
	mov al,0xbb
	mov ah,0xcc
	mov ax,0xdddd

	mov ebx,0
	mov ecx,0

	; Move register to register
	mov ebx,eax
	mov cl,al
	mov ch,ah
	mov cx,ax

	mov eax,0
	mov ebx,0
	mov ecx,0
		
	; Move from memory into register
	mov al,[sample]
	mov ah,[sample+1]
	mov bx,[sample]
	mov ecx,[sample]

	; Move from register into memory
	mov eax,0x33445566
	mov byte[sample],al
	mov word[sample],ax
	mov dword[sample],eax

	; Move immediate value into memory
	mov dword[sample],0x33445566

	; lea demo	
	lea eax,[sample]
	lea ebx,[eax]

	; xchg demo
	mov eax,0x11223344
	mov ebx,0xaabbccdd
	xchg eax,ebx

	; Exit Gracefully
        mov eax,0x1             	; 1 -> FC for exit
        mov ebx,0x0             	; return value
        int 0x80                	; syscall

section .data
	sample: db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x12

