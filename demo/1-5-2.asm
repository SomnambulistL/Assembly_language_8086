;judge count of negative number
data segment 
	count db 06
	array db 12h,88h,82h,90h,22h,33h,?
data ends

code segment
	assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	mov si,offset count
	xor cx,cx
	xor dx,dx
	mov cl,[si]
	inc si
_loop:
	mov al,[si]
	and al,10000000b
	cmp al,0
	jz continue
	inc dx
continue:
	inc si
	loop _loop
	inc si
	mov [si],dl
	
	mov ah,4ch
	int 21h
code ends
	end start