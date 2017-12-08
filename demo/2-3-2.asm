;water led
code segment
assume cs:code
start:
;---------init---------
init:
	mov al,10000000	; 方式选择
	out 06h,al
	mov al,00000000	; c口
	out 06h,al
;-----------------------
_func:
	mov al,00000001
	mov ah,10000000
	out 02h,al
	out 04h,ah
	call _wait
	rol al,1
	ror ah,1
	jmp _func
;---------wait-------------	
_wait proc near:
	push cx
	mov cx,100000
_loop0:
	nop
	nop
	loop _loop0
	pop cx
	ret
;-------------------
	mov ah,4ch
	int 21h
code ends;
	end start