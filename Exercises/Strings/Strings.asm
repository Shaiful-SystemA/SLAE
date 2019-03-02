; Date: 20/01/2019
; Strings.asm
; Author: Daniele Votta
; Description: Strings.
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
	
_start:
	; copy a string from source to destination

	mov ecx,sourceLen
	lea esi,[source]	; load the address of source into esi
	lea edi,[destination]	; load the address of destination in edi

	cld			; clear direction flag | 0 -> to lower memory to high memory
	rep movsb		; (rep) loop until ecx != 0 | (move byte) assume source string in esi, destination string in edi
	
	; Print destination
        mov eax,0x4             ; 4 -> FC for write
        mov ebx,1               ; stdin=0, stdout=1, stderr=2
        mov ecx,destination     ; message
        mov edx,sourceLen       ; length
        int 0x80                ; syscall

	; string comparison with cmpsb
	; compare source and destination

	mov ecx, sourceLen
	lea esi,[source]
	lea edi,[destination]
	repe cmpsb		; comparison | if equal set the ZF

	jz SetEqual		; jump to SetEqual if ZF = 0
	mov ecx, result2
	mov edx, result2Len
	jmp Print


SetEqual:
	mov ecx,result1
	mov edx, result1Len

Print:

	; Print Message
        mov eax,0x4             ; 4 -> FC for write
        mov ebx,1               ; stdin=0, stdout=1, stderr=2
	int 0x80		; syscall

	; Exit Gracefully
        mov eax,0x1             ; 1 -> FC for exit
        mov ebx,0x0     	; return value
        int 0x80        	; syscall

section .data
	
	source: db "Hello World!", 0xa
        sourceLen equ $-source

	comparison: db "Hello"

	result1: db "Strings are Equal!", 0xa
        result1Len equ $-result1

	result2: db "Strings are Unequal!", 0xa
        result2Len equ $-result2

section .bss

	destination: resb 100
