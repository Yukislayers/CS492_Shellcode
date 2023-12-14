; to compile it I used
; nasm -f elf32 test.s
; ld -melf_i386 -o test test.o

section .text

global _start

_start:
        xor ecx, ecx ; we are putting ecx to 0
        xor eax, eax ; we are putting eax to 0
        xor ebx, ebx ; we are putting ebx to 0

open:
        mov al, 0x05 ; 5 is the sys_open call
        push ecx ; ecx is the second parameter of the function
        push 0x7478742e ; txt. in hex
        push 0x67616c66 ; galf in hex
	push 0x2f7a6975 ; /ziu in hex
	push 0x712f656d ; q/em in hex
	push 0x6f682f2f ; oh// in hex
        mov ebx, esp ; putting the address of the stack in ebx so it points to the pathname string
        int 0x80 ; syscall


; at this point we have the file descriptor in eax

read:
        xchg eax, ebx ; exchange data between ebx and eax
; eax get the address of the pathname
; ebx get the file descriptor
        xchg eax, ecx ; exchange data between ecx and eax
; ecx get the address of the pathname
; eax get 0
        mov al, 0x03 ; 3 is the sys_read call
; sys_read take the file descriptor on ebx
; the buffer on ecx
; the bytes to read on edx
        mov dl, 0x3F ; we want to read maximum 64 bytes
	inc edx
        int 0x80 ; syscall
; at this point in eax, you have the number of bytes you read on eax

write:
        mov edx, eax ; you put the value of eax in edx
        mov bl, 0x01 ; File descriptor 1 is the standard output, it is in ebx
        mov al, 0x04 ; 4 is the sys_write call
        int 0x80 ; syscall

exit:
        mov al, 0x01 ; 1 is the sys_exit call
        int 0x80 ; syscall
