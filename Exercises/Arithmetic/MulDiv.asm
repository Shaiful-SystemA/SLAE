; Date: 19/01/2019
; MulDiv.asm
; Author: Daniele Votta
; Description: Moltiplication and Division Operations.
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:

	; OF = 1 -> Overflow Flag and CF = 1 -> Carry Flag | If upper half of result is non-zero
	; For 8bit the mul -> First number stored in AL, Second number stored in BL -> Result stored in AX
	; For 16bit the mul -> First number stored in AX, Second number stored in BX -> Result stored in DX|AX
	; For 32bit the mul -> First number stored in EAX, Second number stored in EBX -> Result stored in EDX|EAX
       
	; unsigned r/m8 multiplication
	mov eax,0x0
	
	mov al,0x10			; First number
	mov bl,0x2			; Second number
	mul bl				; Result stay in AX

	mov al,0xff
	mul bl

	; unsigned r/m16 multiplication

	mov eax,0x0
	mov ebx,0x0
	
	mov ax,0x1122			; First number
	mov bx,0x0002			; Second number
	mul bx				

	mov ax,0x1122			; First number
	mov bx,0x1122			; Second number
	mul bx				; Result stay in DX|AX

	; unsigned r/m32 multiplication
	
	mov eax,0x11223344		; First number
	mov ebx,0x00000002		; Second number
	mul ebx
	
	mov eax,0x11223344		; First number
	mov ebx,0x55667788		; Second number
	mul ebx				; Result stay in EDX|EAX

	; multiplication using memory locations

	mul byte[var1]		
	mul word[var2]
	mul dword[var3]

	; division using r/m8

	mov ax,0x788 + 0x1		; First number
	mov cx,0x2			; Second number
	div cx				; Result stay in -> Q (quotient) -> AL | R (reminder) -> AH
	
	; division using r/m16

	mov eax,0x0
	mov ebx,0x0
	mov ecx,0x0

	mov dx,0x0			; Combination DX|AX First number
	mov ax,0x7788			; Combination DX|AX First number
	mov cx,0x2			; Second number
	div cx				; Result stay in -> Q (quotient) -> AX | R (reminder) -> DX

	; division using r/m32

	mov eax,0x0
	mov ebx,0x0
	mov ecx,0x0

	mov edx,0x11223344		; Combination EDX|EAX First number
	mov eax,0x55667788		; Combination EDX|EAX First number
	mov ecx,0x2			; Second number
	div ecx				; Result stay in -> Q (quotient) -> EAX | R (reminder) -> EDX

	
	; Exit Gracefully
        mov eax,0x1             		; 1 -> FC for exit
        mov ebx,0x0             		; return value
        int 0x80                		; syscall

section .data
	
	var1 db 0x55
	var2 dw	0x1122
	var3 dd	0x11223344
