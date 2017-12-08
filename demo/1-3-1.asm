;output string by 09h 
data segment 
	string1 db 'GOOD AFTERNOON$'
data ends

code segment
	assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
;-----------show---------
	mov dx,offset string1
	mov ah,09h
	int 21h
;-----------exit----------	
	mov ah,4ch
	int 21h 
	
code ends
	end start