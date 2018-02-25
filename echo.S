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

_print:
    movb $1, %al
    syscall
    ret

_start:
    movb $1, %dil
    while:
        decb (%rsp)
        jz line
        movq 16(%rsp,%r9,8), %rsi

        xorq %rdx, %rdx
        .L01:
            cmpb $0, (%rsi,%rdx)
            jz normal
            incb %dl
            jmp .L01

        normal:
        call _print

space:
movb $0x20, (%rsi)
jmp .L03
line:
movb $0x0a, (%rsi)
.L03:
andq $1, %rdx
call _print

.L02:
    cmpb $0, (%rsp)
    je _exit

    incb %r9b
    jmp while

_exit:
    movb $60, %al
    syscall

filesize:
.equ FILESIZE, filesize - _start

