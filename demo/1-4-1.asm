;move data from src to dst
data segment 
	src db 100 dup('A')
	org 300h
	dst db 100 dup(?)
data ends

code segment
	assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
;-------init-------
	mov cx,8
	mov si,offset src
	mov di,offset dst
;-------branch-----
	cmp si,di
	jb _less
;-------si>di-----------
_more:
_loop0:
	mov bl,[si]
	mov [di],bl
	inc si
	inc di
	loop _loop0
	jmp exit
;--------si<di--------
_less:
	add si,cx
	add di,cx
_loop1:
	mov bl,[si]
	mov [di],bl
	dec si
	dec di
	loop _loop1
;--------exit----------
exit:
	mov ah,4ch
	int 21h
code ends
	end start

