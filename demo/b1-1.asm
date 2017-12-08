;compare two string
data segment 
	string1 db 'huibian'
	string2 db 'jiekou'
	result1 db 'MATCH$'
	result2 db 'NO MATCH$'
data ends

code segment
	assume ds:data,cs:code,es:data
start:
	xor ax,ax
	mov ax, data
	mov ds,ax
	mov es,ax
;--------------------
	mov si,offset string1
	mov di,offset string2
	mov cx,7
	cld
	repz cmpsb
	jz _match
_unmatch:
	mov dx,offset result2
	mov ah,9
	int 21h
	jmp exit
_match:
	mov dx,offset result1
	mov ah,9
	int 21h
	
exit:
	mov ah,4ch
	int 21h
code ends
	end start