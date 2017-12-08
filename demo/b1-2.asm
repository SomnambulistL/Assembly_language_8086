;compare if bl bit0 and bit1 is same

code segment
	assume cs:code
start:
	xor ax,ax
	xor bx,bx
	mov bl,00000101b
	shr bl,1
	jnz _differ
_same:
	mov cl,3
	shr bl,cl
	jnz _differ
	mov al,01h
	jmp exit
_differ:
	mov bl,00h
exit:
	mov ah,4ch
	int 21h
code ends
	end start