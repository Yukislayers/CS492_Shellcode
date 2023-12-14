; To compile it I used nasm -f elf32 [filename]
; ld -melf_i386 -o [filename] [filename].o


section .text

global _start

_start:
        xor ecx, ecx ; we are putting ecx to 0
        mul ecx

open:
        mov al, 0x05 ; 5 is the sys_open call
        push ecx ; ecx is the second parameter of the function
        push 0x7478742e ; txt. in hex
        push 0x67616c66 ; galf in hex
        mov ebx, esp ; putting the address of the stack in ebx so it points to the pathname string
        int 0x80 ; syscall

; at this point we have the file descriptor in eax

read:

        xchg eax, ebx ; exchange data between ebx and eax
; eax get the address of the pathname
; ebx get the file descriptor
	mov esi, ebx ; we put the file descriptor in esi for the close syscall
        xchg eax, ecx ; exchange data between ecx and eax
; ecx get the address of the pathname
; eax get 0
        mov al, 0x03 ; 3 is the sys_read call
; sys_read take the file descriptor on ebx
; the buffer on ecx
; the bytes to read on edx
        mov dl, 0x40 ; we want to read maximum 64 bytes
        int 0x80 ; syscall
; at this point in eax, you have the number of bytes you read 

write:

        mov edx, eax ; you put the value of eax in edx, and the value of edx in eax
	mov bl, 0x01 ; File descriptor 1 is the standard output, it is in ebx
	mov al, 0x04 ; 4 is the sys_write call
        int 0x80 ; syscall

close:
	
	xchg esi, ebx ; we put the file descriptor in ebx
	mov al, 0x05 ; 5 is the sys_close call
	int 0x80 ; syscall

exit:
	xor eax, eax
        mov al, 0x01 ; 1 is the sys_exit call
        int 0x80 ; syscall