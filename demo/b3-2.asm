;input a month output the english
data segment
	month db 10,0,10 dup(?)
	org 15
	month1 db 'January$'
	org 30
	month2 db 'February$'
	org 45
	month3 db 'March$'
	org 60
	month4 db 'April$'
	org 75
	month5 db 'May$'
	org 90
	month6 db 'June$'
	org 105
	month7 db 'July$'
	org 120
	month8 db 'August$'
	org 135
	month9 db 'September$'
	org 150
	month10 db 'October$'
	org 165
	month11 db 'November$'
	org 180
	month12 db 'December$'
	string db 'error$'
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
	call _input
    mov ax,dx
	mov cl,15
	mul cl
	mov dx,ax
	mov ah,09h
	int 21h
	mov ah,4ch
	int 21h
	
_input proc near
	push ax
	push bx
	push cx
;--------------
	mov dx,offset month
	mov ah,0ah
	int 21h
	xor dx,dx
	mov si,offset month
	add si,2
	mov bh,[si]
	inc si
	mov bl,[si]
	cmp bl,0dh
	jnz _func1
	sub bh,'0'
	mov dl,bh
	jmp _judge 
_func1:
	sub bh,'0'
	sub bl,'0'
	mov al,bh
	mov cl,10
	mul cl
	add al,bl
	mov dl,al
_judge:
	cmp dl,1
	jb _error
	cmp dl,12
	ja _error
	jmp _exit
_error:
	mov dx,offset string
	mov ah,09h
	int 21h
	mov ah,4ch
	int 21h
_exit:
	pop cx
	pop bx
	pop ax
	ret
;----------------

code ends
	end start
