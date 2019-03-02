; Date: 26/01/2019
; Exit.asm
; Author: Daniele Votta
; Description: Exit with no nulls.
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:

        ; Exit Gracefully
	xor eax, eax
	inc eax
        int 0x80                ; syscall


