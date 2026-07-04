section .data
	command db "Enter Input:", 10
	length equ $ - command
	
    msg_alpha   db "Alphabets:", 10
    len_alpha   equ $ - msg_alpha
 
    msg_digits  db "Digits:", 10
    len_digits  equ $ - msg_digits
 
    msg_special db "Special Symbols:", 10
    len_special equ $ - msg_special
 
    colon       db ":", 0
    newline     db 10
 
    char_buf    db 0            
    num_buf     times 12 db 0   
 
section .bss
    input_buf   resb 1000
    freq        resd 256        
 
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
	    mov ecx, input_buf
	    mov edx, 1000
	    int 0x80
	    mov esi, eax        
 
    xor edi, edi       
	count_loop:
	    cmp edi, esi
	    jge done_count
	    movzx ebx, byte [input_buf + edi]  
	    inc dword [freq + ebx*4]            
	    inc edi
	    jmp count_loop
 
	done_count:
	   print_alpha:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, msg_alpha
	    mov edx, len_alpha
	    int 0x80
 
		    mov ecx, 'A'
			print_AZ:
			    cmp ecx, 'Z' + 1
			    je print_az
			    push ecx
			    call print_nz_freq
			    pop ecx
			    inc ecx
			    jmp print_AZ
			print_az:
			    mov ecx, 'a'
			print_az_loop:
			    cmp ecx, 'z' + 1
			    je print_digits
			    push ecx
			    call print_nz_freq
			    pop ecx
			    inc ecx
			    jmp print_az_loop
 
	    print_digits:
		    mov eax, 4
		    mov ebx, 1
		    mov ecx, msg_digits
		    mov edx, len_digits
		    int 0x80
 
		    mov ecx, '0'
			print_09:
			    cmp ecx, '9' + 1
			    je print_special_header
			    push ecx
			    call print_nz_freq
			    pop ecx
			    inc ecx
			    jmp print_09
 
		print_special_header:
		    mov eax, 4
		    mov ebx, 1
		    mov ecx, msg_special
		    mov edx, len_special
		    int 0x80
 
		    xor ecx, ecx
			print_special_loop:
			    cmp ecx, 256
			    je exit
			    cmp ecx, '0'
			    jb check_special
			    cmp ecx, '9'
			    jle skip_special
			    cmp ecx, 'A'
			    jb check_special
			    cmp ecx, 'Z'
			    jle skip_special
			    cmp ecx, 'a'
			    jb check_special
			    cmp ecx, 'z'
			    jle skip_special
 
		check_special:
		    push ecx
		    call print_nz_freq
		    pop ecx
		    jmp next_special
		skip_special:
		next_special:
		    inc ecx
		    jmp print_special_loop
 
		exit:
		    mov eax, 1
		    xor ebx, ebx
		    int 0x80
 
	print_nz_freq:
	    mov ebx, dword [esp + 4]
	    and ebx, 0xFF                
	 
	    mov eax, [freq + ebx*4]    
	    test eax, eax
	    jz freq_zero
	 
	    push eax                    
	 
	    ; print character
	    mov [char_buf], bl
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, char_buf
	    mov edx, 1
	    int 0x80
	 
	    ; print colon
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, colon
	    mov edx, 1
	    int 0x80
	 
	    pop eax                       
	    call print_freq_num
	 
	    ; print newline
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, newline
	    mov edx, 1
	    int 0x80
	 
	freq_zero:
	    ret
	 
	print_freq_num:
	    mov edi, num_buf
	    add edi, 12         
	 
	loop_digits:
	    xor edx, edx
	    mov ebx, 10
	    div ebx               
	    add dl, '0'
	    dec edi
	    mov [edi], dl
	    cmp eax, 0
	    jne loop_digits
	 
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, edi
	    mov edx, num_buf
	    add edx, 12
	    sub edx, ecx
	    int 0x80
	 	ret
