;judge if student pass exam
data segment
	grade	db 30,40,50,60,70,80,90
	pass	db ?
	fail	db ?	
data ends

stack segment
	dw 100 dup(?)
stack ends

code segment
	assume ds:data,ss:stack,cs:code
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
;--------initi------------
	mov si,offset grade
	mov cx,7
	xor bx,bx
	mov bl,60
	xor ax,ax
	pc=0
	fc=0
_loop:
	mov al,grade
	cmp al,bl
	jae _pass
	fc=fc+1
	jmp func
_pass:
	pc=pc+1
func:
	inc si
	loop _loop
	xor cx,cx
	add cl,pc
	mov [si],cl
	inc si
	add ch,fc
	mov [si],ch
;--------exit---------
	mov ah,4ch
	int 21h
code ends
	end start