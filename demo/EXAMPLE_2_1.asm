;try any ways to store 1234H in a word of storage 
datas segment
	string DW 1234H
datas ends

codes segment
	assume cs:codes,ds:datas
start:
	mov ax,datas
	mov ds,ax
	
	mov ah,4ch
	int 21h
codes ends
	end start