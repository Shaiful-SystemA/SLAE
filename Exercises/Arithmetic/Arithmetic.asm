; Date: 19/01/2019
; Arithmetic.asm
; Author: Daniele Votta
; Description: Arithmetic Operations.
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:
       
	; register based addition

	mov eax,0
	add al,0x22
	add al,0x11

	mov ax,0x1122
	mov ax,0x3344

	mov eax,0xffffffff
	add eax,0x10				; produce carry

	; memory based addition

	mov eax,0
	add byte[var1],0x22
	add byte[var1],0x11

	add word[var2],0x1122
	add word[var2],0x3344

	mov dword[var3],0xffffffff
	add dword[var3],0x10			; produce carry

	; set /clear / complement carry flag
	
	clc	; clear carry flag	
	stc	; set carry flag
	cmc	; complement carry flag

	; add with carry

	mov eax,0
	stc					; set carry flag
	adc al,0x22				; add with carry (add value 22 +1 if CF is setted)
	stc					; set carry flag
	adc al,0x11				; add with carry (add value 11 +1 if CF is setted)

	mov ax,0x1122
	stc					; set carry flag
	adc ax,0x3344				; add with carry (add value 3344 +1 if CF is setted)

	mov eax,0xffffffff
	stc					; set carry flag
	adc eax,0x10				; add with carry (add value 10 +1 if CF is setted)

	; subtract

	mov eax,10
	sub eax,5
	stc					; set carry flag
	sbb eax,4				sub with carry (sub value 4 -1 if CF is setted)

	; increment and decrement

	inc eax
	dec eax

	; Exit Gracefully
        mov eax,0x1             		; 1 -> FC for exit
        mov ebx,0x0             		; return value
        int 0x80                		; syscall

section .data
	
	var1 db 0x00 				; byte
	var2 dw 0x0000				; word
	var3 dd	0x00000000			; double word


