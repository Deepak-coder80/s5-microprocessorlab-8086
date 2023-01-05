data segment 
	msg1 db "please enter the first operand = $"
	msg2 db 0DH,0AH,"please enter the second operand = $"
	res1 db 0DH,0AH,"Result = $"
	A db 00H
	B db 00H
	C dw 00H
data ends

code segment
	assume cs:code,ds:data
	start:
		mov ax,data
		mov ds,ax
		
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
		mov ah,00H
		mul  B;
		mov C,ax;
		
		lea dx,res1;
		mov ah,09h;
		int 21h;
		lea si,C;
		inc si;
		call output;
		dec si;
		call output;
		
		mov ah,4cH;
		int 21H;
		
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
