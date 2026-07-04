;; 
; Welcome to GDB Online.
; GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
; C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
; Code, Compile, Run and Debug online from anywhere in world.
; 
; 
section .data
    cmd1 db "Enter Doc: ", 10
    len1 equ $ - cmd1
    
    cmd2 db "Enter char: ", 10
    len2 equ $ - cmd2
    
    newline db 10
    msg db "no of iterations: "
    len equ $ - msg
    one db '1'
    zero db '0'

    
section .bss
    buff resb 1000
    charr resb 1
    numstr resb 12
    
section .text
    global _start

_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, cmd1
    mov edx, len1
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buff
    mov edx, 1000
    int 0x80
    mov esi, eax

    mov eax, 4
    mov ebx, 1
    mov ecx, cmd2
    mov edx, len2
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, charr
    mov edx, 1
    int 0x80

    mov edi, buff
    xor ecx, ecx
    search_loop:
        cmp esi, 0
        jle not_found
        
        mov bl, [edi]
        cmp [charr], bl
        je found
        
        inc edi
        inc ecx
        dec esi
        jmp search_loop
    
    not_found:
        mov eax, 4
        mov ebx, 1
        mov ecx, zero
        mov edx, 1
        int 0x80
        jmp exit
    found:
        push ecx
        
        mov eax, 4
        mov ebx, 1
        mov ecx, one
        mov edx, 1
        int 0x80
        
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 0x80
        
        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, len
        int 0x80
        
        pop ecx
        mov eax, ecx
    mov ecx, numstr+12
    write_int:
        xor edx, edx
        mov ebx, 10
        div ebx
        add dl, '0'
        dec ecx
        mov [ecx], dl
        test eax, eax
        jnz write_int
        
        mov eax, 4
        mov ebx, 1
        mov edx, numstr+12
        sub edx, ecx
        int 0x80
        
    exit:
    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80
