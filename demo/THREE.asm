;EXAMPLE 2-3
data segment
	count dd 0FFFA000h
data ends

stack segment
	dd 10 dup(?)
stack ends

codes segment
	assume cs:codes,ds:data,ss:stack
	
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	
	mov ax,word ptr count	;A000
	push ax
	mov bx,word ptr count+2	;ffff
	mov cl,4
	shl bx,cl
	rol ah,cl
	and ah,0Fh
	add bl,ah
	pop ax
	shl ax,cl
	mov word ptr count,ax
	mov word ptr count,bx
	
	mov ah,4ch
	int 21h
codes ends
	end start