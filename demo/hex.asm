;HEX TO BIN
codes segment
	assume cs:codes
main proc far
repeat:
	call hexibin
	call crlf
	call show
	call crlf
	jmp  repeat
main endp

hexibin proc near
	mov bx,0
newchar:
	mov ah,1
	int 21h
	cmp al,'0'
	jb exit
	cmp al,'9'
	ja checka
	sub al,30h
	cbw
	xchg ax,bx
	mov cx,16d
	mul cx
	add bx,ax
	jmp newchar
checka:
	cmp al,'A'
	jb exit
	cmp al,'F'
	ja exit
	sub al,37h
	cbw
	xchg ax,bx
	mov cx,16d
	mul cx
	add bx,ax
	jmp newchar
exit:
	ret
hexibin endp


show proc near
	mov ch,16d
	xor dl,dl
rotate:
	rol bx,1d
	mov al,bl
	and al,1d
	add al,30h
	mov dl,al
	mov ah,2
	int 21h
	dec ch
	jnz rotate
	ret
show endp


crlf proc near
	mov dl,0dh
	mov ah,2
	int 21h
	mov dl,0ah
	mov ah,2
	int 21h
	ret
crlf endp
codes ends
	end main



	
	