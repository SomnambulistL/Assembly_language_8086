;show input
data segment
	ibuf db 10,?,10 dup('$')
data ends

code segment
	assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	xor dx,dx
;----------input---------	
	mov dx,offset ibuf
	mov ah,0Ah
	int 21h
;----------clrf-----------
	mov dl,0dh
	mov ah,2
	int 21h
	mov dl,0ah
	mov ah,2
	int 21h
;----------show-------------
	mov dx,offset ibuf+2
	mov ah,09h
	int 21h

;---------exit------------
	mov ah,4ch
	int 21h
code ends
	end start
	
	