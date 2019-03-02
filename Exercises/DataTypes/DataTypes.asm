; Date: 13/01/2019
; DataTypes.asm
; Author: Daniele Votta
; Description: Data Types.
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
        ; Print Message
        mov eax,0x4             	; 4 -> FC for write
        mov ebx,1               	; stdin=0, stdout=1, stderr=2
        mov ecx,message         	; message
        mov edx,mlen            	; length
        int 0x80                	; syscall
        ; Exit Gracefully
        mov eax,0x1             	; 1 -> FC for exit
        mov ebx,0x5             	; return value
        int 0x80                	; syscall

section .data				; Initialized Data
	var1: db 0xAA			; single byte
	var2: db 0xBB, 0xCC, 0xDD	; sequence of byte
	var3: db 0xEE			; single byte
	var4: dd 0xAABBCCDD		; word
	var5: dd 0x112233		; word
	var6: TIMES 6 db 0xFF		; single byte for 6 times
        message: db "Hello World!",0xa
        mlen equ $-message

section .bss				; Uninitialized Data
	var7: resb 100			; reserve 100 bytes
	var8: resw 20			; reserve 20 word
