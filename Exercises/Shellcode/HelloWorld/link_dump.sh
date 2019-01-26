#!/bin/bash

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $1.o $1.asm

echo '[+] Linking ...'
ld -z execstack -o $1 $1.o

echo '[+] Dumping with objdump ... '
objdump -d $1 -M intel

echo '[+] Extract Shellcode ... '
objdump -d $1|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g' > $1_shellcode

cat $1_shellcode

echo '[+] Done!'
