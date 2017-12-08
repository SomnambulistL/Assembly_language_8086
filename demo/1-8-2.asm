code segment
	assume cs:code
start:
	count=0
	mov cx,4
_loop:
	count=count+1
	loop _loop
	xor ax,ax
	add ax,count
	mov ah,4ch
	int 21h
code ends
	end start