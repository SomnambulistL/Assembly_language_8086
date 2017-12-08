;input a count in hex output binary
data segment
	hex db 10,0,10 dup(?)
	string db 'error$'
stack segment 
	dw 100 dup(?)
stack ends

code segment
	assume ds:data,cs:code,ss:stack
start:
	xor ax,ax
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
_input:
	mov dx,offset hex
	mov ah,0ah
	int 21h
	mov dl,0ah
	mov ah,02h
	int 21h
	mov dl,0dh
	mov ah,02h
	int 21h
	xor dx,dx
	mov cx,4
_loop:
_transfer:
	push cx
	mov si,offset HEX
	inc si
	inc si
	inc si
	mov bl,[si]
	cmp bl,'0'
	jb _error
	cmp bl,'9'
	ja _alpha
	sub bl,'0'
	mov cl,4
	shl dx,cl
	add dl,bl
	jmp _trans_end
_alpha:
	cmp bl,'A'
	jb _error
	cmp bl,'F'
	ja _error
	mov cl,4
	shl dx,cl
	sub bl,'A'
	add bl,10
	add dl,bl
_trans_end:
	pop cx
	inc si
	loop _loop
	mov cx,16
_show:
	rol dx,1
	mov bl,dl
	and bl,01h
	add bl,'0'
	push dx
	mov dl,bl
	mov ah,02h
	int 21h
	pop dx
	loop _show
	jmp exit
_error:
	mov dx,offset string
	mov ah,09h
	int 21h
exit:
	mov ah,4ch
	int 21h
code ends
	end start