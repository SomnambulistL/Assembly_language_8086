data segment
	org 3000h
	array db 1,2,3,4,5,6,7,8
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
;------init---------
	mov cx,8
	xor ax,ax
	xor bx,bx
	mov si,offset array
	mov bl,[si]
	mov bh,bl
_loop:
	mov al,[si]
	cmp al,bl
	jb _min
	jmp _max
_min:
	mov bl,al
_max:
	cmp al,bh
	jb func
	mov bh,al
func:
	inc si
	loop _loop
;-------exit---------
	mov ah,4ch
	int 21h
code ends
	end start