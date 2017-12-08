data segment
	org 3000
	buf db 8 dup(?)
	count = 8
data ends
code segment
main proc far
start:
	assume cs:code,ds:data
     	push ds
	sub ax,ax
	push ax

	mov ax,data
	mov ds,ax

	mov si,offset buf
	mov cx,count
	call maxmin
        ret
main endp

maxmin proc near

	cmp cx,0
	jz exit
	push si
	push cx
	push bx
	
	mov bh,[si]
	mov bl,bh
	
loop1:
	inc si
	mov al,[si]
	cmp al,bh
	jae fact1
	cmp al,bl
	jbe fact2
loop2:
	dec cx
	cmp cx,0

	jnz loop1
	jz exit
	
fact1:
	mov bh,al
	jmp loop2

fact2:
	mov bl,al
	jmp loop2
exit:
	ret

maxmin endp
code ends
end start