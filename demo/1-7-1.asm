;find max,min
data segment
	org 3000h
	array db 1,2,3,4,5,6,7,8
data ends


stack segment
	dw 100 dup(?)
stack ends


code segment
	assume ds:data,ss:stack,cs:code
;main pro
main proc far
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax

	mov si,offset array
	mov cx,07h
	
	call max_min 
	
	mov ah,4ch
	int 21h
main endp

;child pro
max_min proc near:
	cmp cx,0h
	jz exit
	push si
	push cx
	push bx
	
	mov bh,[si]
	mov bl,bh
compare:
	inc si
	mov al,[si]
	cmp al,bh
	jae min
	cmp al,bl
	jbe max
	jmp dec_cx
min:
	mov bh,al
	jmp	dec_cx
max: 
	mov bl,al
	
dec_cx:
	dec cx
	cmp cx,0h
	jnz compare
exit:
	ret
max_min endp

code ends
	end main