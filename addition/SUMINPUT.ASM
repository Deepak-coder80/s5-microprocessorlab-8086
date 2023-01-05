data segment
	msg1 db "Please enter the first number : $"
	msg2 db 0DH,0AH,"Please enter the second number : $"
	msg3 db 0DH,0AH,"Sum = $ "
	msg4 db 0DH,0AH,"Carry = $"
	
	A db 00H;
	B db 00H;
	sum db ?;
	carry db 00H;
data ends

code segment 
	assume cs:code ,ds:data
	
	start:
		mov ax,data;
		mov ds,ax;
		
		lea dx,msg1;
		mov ah,09h;
		int 21h;
		call input;
		mov A,al;
		
		lea dx,msg2;
		mov ah,09h;
		int 21h;
		call input;
		mov B,al;
		
		mov al,A;
		add al,B;
		jnc skip;
		inc carry
		skip: mov sum,al;
		
		lea dx,msg3;
		mov ah,09h
		int 21h;
		lea si,sum;
		call output;
		
		lea dx,msg4;
		mov ah,09h
		int 21h;
		lea si,carry;
		call output;
		
		mov ah,4ch
		int 21h;
input proc near 
	push cx;
	mov ah,01h;
	int 21h;
	sub al,30h;
	cmp al,09h;
	jle p1;
	sub al,07h;
	p1: mov cl,04h;
	rol al,cl; 
	mov ch,al;
	mov ah,01h;
	int 21h;
	sub al,30h;
	cmp al,09h;
	jle p2;
	sub al,07h;
	p2: add al,ch;
	pop cx;
	ret;
input endp;


output proc near
	push cx;
	mov al,[si];
	and al,0f0H;
	mov cl,04H;
	rol al,cl;
	add al,30h;
	cmp al,39h;
	jle g1;
	add al,07h;
	g1: mov dl,al;
	mov ah,02h;
	int 21h;
	mov al,[si];
	and al,0FH;
	add al,30h;
	cmp al,39h;
	jle g2;
	add al,07h;
	g2: mov dl,al;
	mov ah,02h;
	int 21h;
	pop cx;
	ret
output endp;

code ends
end start
