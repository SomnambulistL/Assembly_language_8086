;move data from 3500h to 3600h
data segment
	org 3500h
	str1 db 'abcdefgh'
	org 3600h
	str2 db 8 dup (?)
data ends

code segment 
	assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	
	mov si,offset str1
	mov di,offset str2
	mov cx,08h
repeat:
	mov ax,[si]
	mov ds:[di],ax
	inc si
	inc di
	dec cx
	cmp cx,0
	loop repeat

	mov ah,4ch
	int 21h
code ends
	end start