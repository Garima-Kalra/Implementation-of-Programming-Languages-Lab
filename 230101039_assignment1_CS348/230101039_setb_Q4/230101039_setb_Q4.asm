section .data
command db "Enter Input: ", 10
length equ $ - command

section .bss
buffer resb 500
temp resb 1

section .text
	global _start

_start:
    give_command:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, command
	    mov edx, length
	    int 0x80
    
    take_input:
	    mov eax, 3
	    mov ebx, 0
	    mov ecx, buffer
	    mov edx, 1000
	    int 0x80
    
	    mov esi, buffer
	    mov edx, eax
    
    loop_start:
	    cmp edx, 0
	    je exit
    
	    push ecx
	    push edx
    
	    mov al, [esi]
	    
	    cmp al, 'A'
	    jb branch_not_alpha
	    jae check1

	    print:
		    mov [temp], al
		    mov eax, 4
		    mov ebx, 1
		    mov ecx, temp
		    mov edx, 1
		    int 0x80
    
	    pop edx
	    pop ecx
	    
	    inc esi
	    dec edx
	    
	    jmp loop_start
    
    check1:
    	cmp al, 'Z'
    	jb branch_default
    	je branch_Z
		ja check2
    	
    check2:
		cmp al, 'a'
		jb branch_not_alpha
		jae check3
		
	check3:
		cmp al, 'z'
		jb branch_default
	    je branch_z
	    ja branch_not_alpha
		
    branch_default:
    	inc al
    	jmp print
    branch_not_alpha:
    	jmp print
    branch_Z: 
	    mov al, 'a'
	    jmp print
    branch_z:
	    mov al, 'A'
	    jmp print
    exit:
	    mov eax ,1
	    mov ebx, 0
	    int 0x80
