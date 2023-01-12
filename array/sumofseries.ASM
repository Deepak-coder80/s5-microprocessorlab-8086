
data segment
	ms1 db "ENTER SIZE OF ARRAY = $"
	ms2 db 0DH,0AH,"ENTER ELEMENTS OF ARRAY :  $"
	ms3 db 0DH,0AH,"ELEMENTS OF ARRAY  ARE :  [$"
	coma db " , $"
	close db "]$"
	sumst db 0DH,0AH,"SUM OF ARRAY ELEMENTS = $"
	lb  db 0DH,0AH," $"
	dot db " : $"
	array db 255 DUP(00H)
	arrlen db 00h
	sumarr dw 0000h
data ends

code segment
	assume cs:code,ds:data

	start: 
		mov ax,data
		mov ds,ax

		lea dx,ms1
		mov ah,09h
		int 21h;
		call input
		mov cl,al;
		mov arrlen,cl
		
		lea dx,ms2
		mov ah,09h
		int 21h;

		;BELOW CODE WILL TAKE AN ARRAY 

		lea si,array
		mov bl,01h;
		loop1: 	
		lea dx,lb
		mov ah,09h
		int 21h;
		mov dl,bl
		add dl,30h
		mov ah,02h
		int 21h
		lea dx,dot
		mov ah,09h
		int 21h
		inc bl
		call input
		mov [si],al	
		inc si
		dec cl
		jnz loop1

		lea si,array
		mov ch,arrlen

		;THIS WILL PRINT ARRAY

		lea dx,ms3
		mov ah,09h
		int 21h 
		

		rep1:
		call output
		lea dx,coma
		mov ah,09h
		int 21h
		inc si
		dec ch
		jz exit
		jmp rep1

		exit:
		lea dx,close
		mov ah,09h
		int 21h 

		; BELOW CODE PERFOM CALCULATE SUM OF ELEMENTS AND PRINT


		lea si,array
		mov ch,arrlen

		mov ax,0000h
		mov ah,00h
		rep2: add al,[si]
		daa 
		jnc skip
		mov bh,al
		mov al,ah
		add al,01h
		daa
		mov ah,al
		mov al,bh
		skip: inc si
		dec ch
		jnz rep2

		mov sumarr,ax
		

		lea dx,lb
		mov ah,09h
		int 21h 

		lea dx,sumst
		mov ah,09h
		int 21h

		
		lea si,sumarr
		inc si
		call output
		dec si
		call output


		

		exit2: mov ah,4ch
		int 21h

input proc near
	push cx
	mov ah,01h
	int 21h
	sub al,30h
	cmp al,09h
	jle p1
	sub al,07h	
	p1:mov cl,04h
	rol al,cl 
	mov ch,al
	mov ah,01h
	int 21h
	sub al,30h
	cmp al,09h
	jle p2
	sub al,07h
	p2:add al,ch
	pop cx
	ret
input endp

output proc near
	push cx
	mov al,[si]
	and al,0f0h
	mov cl,04h
	rol al,cl
	add al,30h
	cmp al,39h
	jle g1
	add al,07h
	g1: mov dl,al
	mov ah,02h
	int 21h
	mov al,[si]
	and al,0fh
	add al,30h
	cmp al,39h
	jle g2
	add al,07h
	g2: mov dl,al
	mov ah,02h
	int 21h
	pop cx
	ret 
output endp

code ends
end start