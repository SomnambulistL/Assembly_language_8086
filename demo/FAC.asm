;FACTORIAL
data segment
	n_v dw 4
	result dw ?
data ends


stack segment
	dw 100 dup(?)
stack ends


code segment
	assume ds:data,ss:stack,cs:code
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	
	mov bx,n_v
	push bx
	call fact
	pop result
	
	sub ax,ax
	sub bx,bx
	sub cx,cx
	mov bx,result
	jmp show


fact proc  near
    push  ax
    push  bp
    mov   bp, sp
    mov   ax, [bp+6]
    cmp   ax, 0
    jne   fact1
    inc   ax
    jmp   exit

fact1: 
	dec   ax
    push  ax
    call  fact
    pop   ax
    mul   word ptr[bp+6]

exit:  
    mov   [bp+6], ax
    pop   bp
    pop   ax
    ret   
show:
	mov ch,16d
	xor dl,dl
rotate:
	rol bx,1d
	mov al,bl
	and al,1d
	add al,30h
	mov dl,al
	mov ah,2
	int 21h
	dec ch
	jnz rotate	
	
fact   endp
code ends
	end start


