;sort grade of students
data segment 
	org 3000h
	grade db 2,1,8,7,6,5
	org 3100h
	sort1 db 0,1,2,3,4,5
	org 3200h 
	sort2 db 6 dup(?)
data ends

stack segment
	dw 100 dup (?)
stack ends

code segment
	assume ds:data,ss:stack,cs:code
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
;------init----------
	mov si,offset grade
	mov di,offset sort1
	xor cx,cx
	mov cl,5
	xor ax,ax
	xor bx,bx
	xor dx,dx
;-------sort-----------
_loop0:
	push cx
	push si
	push di
_loop1:
	mov bl,[si]
	mov bh,[si+1]
	mov al,[di]
	mov ah,[di+1]
	cmp bl,bh
	jb _branch
	jmp _func
_branch:
	mov [si],bh
	mov [si+1],bl
	mov [di],ah
	mov [di+1],al
_func:	
	inc si
	inc di
	loop _loop1
	pop di
	pop si
	pop cx
	loop _loop0
;------sort2-----------
	mov cx,6
	mov si,offset sort1
	mov di,offset sort2
	xor bp,bp
	xor bx,bx
	xor ax,ax
_loop3:
	mov al,[si+bx]
	mov bp,ax
	mov ds:[di+bp],bx
	inc bx
	loop _loop3
;-----exit--------------
	mov ah,4ch
	int 21h
code ends
	end start