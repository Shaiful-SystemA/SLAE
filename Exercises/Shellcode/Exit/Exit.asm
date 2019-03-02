; Date: 26/01/2019
; Exit.asm
; Author: Daniele Votta
; Description: Exit.
;
; Exit: FC 1 - SYNOPSIS
;      #include <unistd.h>
;      void _exit(int status);

global _start:

section .text

_start:

        ; Exit Gracefully
        mov eax,0x1             ; 1 -> FC for exit
        mov ebx,0x10             ; return value
        int 0x80                ; syscall


