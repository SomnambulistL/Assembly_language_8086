;caculate S=1+2*3+3*4+····N*(N+1)
code segment
	assume cs:code
start:
	mov cx,3 ;cx 为N
	mov dx,0
	mov ax,1
	mov bh,1
	mov bl,2
_loop1:
	add dx,ax
	inc bh
	inc bl
	xor ax,ax
	mov al,bh
	mul bl
	loop _loop1
	mov ah,4ch
	int 21h
code ends
	end start
	