;EXAMPLE_2_2
datas segment
	org 100h
	;db 256 dup(?) 
	address dd 3000f200h

datas ends

codes segment
	assume cs:codes,ds:datas
start:
	mov ax,datas
	mov ds,ax
	mov si,word ptr address
    mov ds,word ptr address+2
    sub ax,ax
    mov ax,ds:[si]
	
	mov ah,4ch
	int 21h
codes ends
	end start