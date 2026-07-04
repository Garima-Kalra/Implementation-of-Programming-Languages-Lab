;; 
; Welcome to GDB Online.
; GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
; C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
; Code, Compile, Run and Debug online from anywhere in world.
; 
; 
section .data
    msg1 db "Enter n", 10
    len1 equ $ - msg1
    
    msg2 db "Enter Array", 10
    len2 equ $ - msg2
    
    out1 db "Minimum Element: "
    leno1 equ $ - out1
    out2 db "Location: "
    leno2 equ $ - out2
    out3 db "Maximum Element: "
    leno3 equ $ - out3
    
    newline db 10 

    mini dd 1000000000
    maxi dd -1000000000
    locmin dd 0
    locmax dd 0

section .bss
    n_ascii resb 12
    n resd 1
    array resb 1000
    arr resd 1000
    numstr resb 12
section .text
    global _start

_start:
    ; write(1, msg, len)
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, n_ascii
    mov edx, 12
    int 0x80
    
    mov ecx, n_ascii
    xor eax, eax
    xor ebx, ebx
    mov bl, 10
    call read_int
    mov [n], eax
    
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, array
    mov edx, 1000
    int 0x80
    
    mov ecx, array
    mov esi, 0
    loop:
        mov dl, [ecx]
        cmp dl, 10
        je done2
        cmp dl, ' '
        je next
        
        xor eax, eax
        xor ebx, ebx
        mov bl, 10
        call read_int
        mov dword [arr+esi*4], eax
        cmp dword eax, [mini]
        jl minimum
        cmp dword eax, [maxi]
        jg maximum
        
    
    next: 
        inc ecx
        jmp loop
    
    minimum:
        mov dword [mini], eax
        mov dword [locmin], esi
        inc esi
        jmp loop
    maximum:
        mov dword [maxi], eax
        mov dword [locmax], esi
        inc esi
        jmp loop
    read_int:
        xor eax, eax          ; result = 0

    next_digit:
        mov dl, [ecx]
        cmp dl, ' '
        je done
        cmp dl, 10           ; newline
        je done

        sub dl, '0'
        movzx edx, dl
        imul eax, eax, 10
        add eax, edx

        inc ecx
        jmp next_digit

    done:
        ret
    done2:
        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, out1
        mov edx, leno1
        int 0x80
        
        mov dword eax, [mini]
        mov ecx, numstr+12
        call write_int
        mov eax, 4
        mov ebx, 1
        mov edx, numstr+12
        sub edx, ecx
        int 0x80
        
        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, newline
        mov edx, 1
        int 0x80
        
        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, out2
        mov edx, leno2
        int 0x80
        
        mov dword eax, [locmin]
        mov ecx, numstr+12
        call write_int
        mov eax, 4
        mov ebx, 1
        mov edx, numstr+12
        sub edx, ecx
        int 0x80
        
        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, newline
        mov edx, 1
        int 0x80
        
        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, out3
        mov edx, leno3
        int 0x80

        mov dword eax, [maxi]
        mov ecx, numstr+12
        call write_int
        mov eax, 4
        mov ebx, 1
        mov edx, numstr+12
        sub edx, ecx
        int 0x80
        
        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, newline
        mov edx, 1
        int 0x80

        mov eax, 4          ; sys_write
        mov ebx, 1          ; stdout
        mov ecx, out2
        mov edx, leno2
        int 0x80
            
        mov dword eax, [locmax]
        mov ecx, numstr+12
        call write_int
        mov eax, 4
        mov ebx, 1
        mov edx, numstr+12
        sub edx, ecx
        int 0x80
        
        jmp exit
    write_int:
        xor edx, edx
        mov ebx, 10
        div ebx
        add dl, '0'
        dec ecx
        mov [ecx], dl
        test eax, eax
        jnz write_int
        
    print:
        ret
    exit:
        mov eax, 1          ; sys_exit
        xor ebx, ebx
        int 0x80
