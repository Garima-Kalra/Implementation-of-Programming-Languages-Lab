section .data
    command     db "Enter Input:", 10
    len_cmd     equ $ - command

    msgBad      db "Invalid Input", 10
    lenBad      equ $ - msgBad

    newline     db 10

section .bss
    n               resb 20
    n_integer       resd 1
    matrix          resb 400
    comp_matrix     resb 400
    trans_matrix    resb 400

section .text
    global _start

_start:
    ; prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, command
    mov edx, len_cmd
    int 0x80

    ; read n
    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 20
    int 0x80

    ;convert ascii to int
    xor eax, eax
    mov esi, n

    convert_loop:
        mov bl, [esi]
        cmp bl, 10
        je convert_done

        imul eax, eax, 10
        sub bl, '0'
        add eax, ebx

        inc esi
        jmp convert_loop

    convert_done:
        mov [n_integer], eax

    read_matrix:
        mov eax, 3
        mov ebx, 0
        mov ecx, matrix
        mov edx, 400
        int 0x80
        mov esi, matrix
        mov ebp, eax  

    mov ecx, [n_integer]
    imul ecx, [n_integer]
    mov edi, comp_matrix

    compact_loop:
        cmp ecx, 0
        je store
        cmp ebp, 0 
        je bad_input

        mov al, [esi]
        cmp al, '0'
        jb bad_input
        mov byte [edi], al
        inc edi
        inc esi
        dec ecx
        dec ebp
        jmp compact_loop

    store:
    xor esi, esi
    xor edi, edi

    outer_loop:
        cmp esi, [n_integer]
        jge print
        inner_loop:
            cmp edi, [n_integer]
            jge next
            mov eax, esi
            imul eax, [n_integer]
            add eax, edi

            mov ebx, edi
            imul ebx, [n_integer]
            add ebx, esi

            mov [trans_matrix+ebx], [comp_matrix+eax]
            inc edi
            jmp inner_loop


    next: 
        inc esi
        jmp outer_loop

    xor esi, esi
    xor edi, edi

    print:
        outer_loop_print:
            cmp esi, [n_integer]
            jge exit
            inner_loop_print:
                cmp edi, [n_integer]
                jge next_print
                mov eax, esi
                imul eax, [n_integer]
                add eax, edi

                mov ebp, eax
               ;print char
                mov eax, 4
                mov ebx, 1
                mov ecx, trans_matrix + ebp
                mov edx, 1
                int 0x80
                
                inc edi
                ; print newline
                mov eax, 4
                mov ebx, 1
                mov ecx, newline
                mov edx, 1
                int 0x80
                jmp inner_loop_print
    
    next_print: 
        inc esi
        jmp outer_loop_print
    exit:
        mov eax, 1
        mov ebx, 0
        int 0x80
    bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgBad
    mov edx, lenBad
    int 0x80
    jmp exit

