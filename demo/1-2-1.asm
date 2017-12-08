;decimal to binary
data segment
	ibuf db 10,?,10 dup(?)
data ends

code segment
	assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	mov si,offset ibuf
;-------input--------
	mov dx,offset ibuf
	mov ah,0Ah
	int 21h
;-------decimal---------
	inc si
	xor cx,cx
	mov cl,[si]
	inc si
	mov dl,10
	xor ax,ax
	xor bx,bx
__loop:
	mov bl,[si]
	sub bl,'0'
	mul dl
	add ax,bx
	inc si
	loop __loop
;------show--------------
__show:
	mov cx,16
	mov bx,ax
;-----crlf----------
	mov dl,0ah
	mov ah,2
	int 21h
	mov dl,0dh
	mov ah,2
	int 21h
__loop1:
	rol bx,1
	mov dl,bl
	and dl,1d
	add dl,'0'
	mov ah,2
	int 21h
	loop __loop1	
;-------exit--------------
	mov ah,4ch
	int 21h
code ends
	end start