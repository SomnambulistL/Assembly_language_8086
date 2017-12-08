;led
code segment
assume cs:code
start:

;--------init----------
_init:
c
;-----------------------
_loop0:
_read:
	in al,00h	; 读pa口

_wait:			; 去抖
	mov cx,10000
_loop1:
	nop
	nop
	loop _loop1
	
_write:
	out 02h,al	; 写入pb口
;--------------------------
	jmp _loop0
	
	mov ah,4ch
	int 21h
code ends
	end start
