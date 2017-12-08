;sort
data segment
	count db 6
	array db 5,6,4,3,7,8
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
;------init--------
	mov si,offset count
	xor cx,cx
	mov cl,[si]
	dec cl
	inc si
_loop0:
	push cx
	push si
_loop1:

	mov bl,[si]
	mov bh,[si+1]
	cmp bl,bh
	ja _branch
	jmp _func
_branch:
	mov [si],bh
	mov [si+1],bl
_func:
	inc si
	loop _loop1
	pop si
	pop cx
	loop _loop0
;------exit-----------
exit:
	mov ah,4ch
	int 21h
code ends
	end start
	