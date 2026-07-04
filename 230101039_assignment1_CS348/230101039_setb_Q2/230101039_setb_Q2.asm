section .data
    command     db "Enter Input:", 10
    len_cmd     equ $ - command

    msgCycle    db "Cycle Found", 10
    lenCycle    equ $ - msgCycle

    msgNoCycle  db "No Cycle", 10
    lenNoCycle  equ $ - msgNoCycle

    msgBad      db "Invalid Input", 10
    lenBad      equ $ - msgBad

section .bss
    n               resb 20
    n_integer       resd 1
    adj_matrix      resb 400
    adj_compact     resb 400
    visited         resd 20
    path_visited    resd 20

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

    ; convert ASCII to integer
    xor eax, eax
    mov esi, n

convert_loop:
    mov bl, [esi]
    cmp bl, 10          ; newline
    je convert_done
    cmp bl, '0'
    jb bad_input
    cmp bl, '9'
    ja bad_input

    imul eax, eax, 10
    sub bl, '0'
    add eax, ebx

    inc esi
    jmp convert_loop

convert_done:
    mov [n_integer], eax

; ---------- read adjacency matrix ----------
read_adj_matrix:
    mov eax, 3
    mov ebx, 0
    mov ecx, adj_matrix
    mov edx, 400
    int 0x80
    mov esi, adj_matrix
    mov ebp, eax        ; bytes available

; ---------- compact matrix ----------
    mov ecx, [n_integer]
    imul ecx, [n_integer]
    mov edi, adj_compact

compact_loop:
    cmp ecx, 0
    je start_dfs
    cmp ebp, 0
    je bad_input

    mov al, [esi]
    inc esi
    dec ebp

    cmp al, '0'
    je store0
    cmp al, '1'
    je store1
    jmp compact_loop

store0:
    mov byte [edi], '0'
    inc edi
    dec ecx
    jmp compact_loop

store1:
    mov byte [edi], '1'
    inc edi
    dec ecx
    jmp compact_loop

; ---------- DFS main ----------
start_dfs:
    xor ecx, ecx

check_all:
    cmp ecx, [n_integer]
    jge no_cycle

    mov eax, [visited + ecx*4]
    cmp eax, 0
    jne next_node

    push ecx
    mov edi, ecx
    call dfs
    pop ecx

    cmp eax, 1
    je cycle_found

next_node:
    inc ecx
    jmp check_all

; ---------- DFS ----------
dfs:
    mov dword [visited + edi*4], 1
    mov dword [path_visited + edi*4], 1

    xor esi, esi

dfs_loop:
    cmp esi, [n_integer]
    jge dfs_end

    mov eax, edi
    mov ebx, [n_integer]
    imul eax, ebx
    add eax, esi

    cmp byte [adj_compact + eax], '1'
    jne dfs_next

    mov eax, [visited + esi*4]
    cmp eax, 0
    jne check_path

    push edi
    mov edi, esi
    call dfs
    pop edi

    cmp eax, 1
    je return_cycle

dfs_next:
    inc esi
    jmp dfs_loop

check_path:
    mov eax, [path_visited + esi*4]
    cmp eax, 1
    je return_cycle
    inc esi
    jmp dfs_loop

dfs_end:
    mov dword [path_visited + edi*4], 0
    mov eax, 0
    ret

return_cycle:
    mov eax, 1
    ret

; ---------- Output ----------
cycle_found:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgCycle
    mov edx, lenCycle
    int 0x80
    jmp exit

no_cycle:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgNoCycle
    mov edx, lenNoCycle
    int 0x80
    jmp exit

bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgBad
    mov edx, lenBad
    int 0x80
    jmp exit

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
