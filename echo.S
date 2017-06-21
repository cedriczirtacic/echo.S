ehdr:
    e_ident:
    .byte   0x7f
    .ascii  "ELF"
    .byte   0x2, 0x1, 0x1, 0x0
.rept 8
    .byte   0x0
.endr
    e_type:
    .byte   0x02, 0x00
    e_machine:
    .byte   0x3e, 0x00
    e_version:
    .word   0x1, 0x0
    e_entry:
    .set _START, _start
    .quad  _START
    e_phoff:
    .set PHOFF_A, phdr - ehdr
    .quad   PHOFF_A
    e_shoff:
    .quad   0x0
    e_flags:
    .word   0x0, 0x0
    e_ehdrsize:
    .byte   EHDR_SIZE, 0x0
    e_phentsize:
    .byte   PHDR_SIZE, 0x0
    e_phnum:
    .byte   0x1, 0x0
    e_shentsize:
    .byte   0x0, 0x0
    e_shnum:
    .byte   0x0, 0x0
    e_shstrndx:
    .byte   0x0, 0x0
ehdr_size:
.equ EHDR_SIZE, ehdr_size - ehdr

phdr:
    .set PHDR_ADDR, phdr
    p_type:
    //p_type LOAD = 1
    .word   0x1, 0x0
    p_flags:
    .word   0x5, 0x0
    p_offset:
    .quad   PHOFF_A
    p_vaddr:
    .quad   PHDR_ADDR
    p_paddr:
    .quad   PHDR_ADDR
    p_filesz:
    .quad   FILESIZE
    p_memsz:
    .quad   FILESIZE
    p_align:
    .quad   0x8
phdr_size:
.equ PHDR_SIZE, phdr_size - phdr

.section .text
.globl _start
_start:
    pushq %rbp
    movq %rsp, %rbp

    decb 8(%rbp)
    jz _exit
    
    movq 24(%rbp), %rbx
    while:
        cmpb $0, (%rbx)
        jne normal
        
        decb 8(%rbp)
        jz line

        movb $0x20, (%rbx)
        jmp normal
        
        line:
        movb $0x0a, (%rbx)

        normal:
        leaq (%rbx), %rsi
_print:
    movb $1, %al
    movb $1, %dil
    movb $1, %dl
    syscall

    cmp $0, 8(%rbp)
    je _exit

    incb %bl
    jmp while

_exit:
    popq %rbp
    movb $60, %al
    syscall

filesize:
.equ FILESIZE, filesize - _start

