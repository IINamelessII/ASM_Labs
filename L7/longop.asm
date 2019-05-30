.586
.model flat, c
.data 
	x dd 1
	n dd 0
	inner dd 5
	outer dd 5
	buf dd 0h
	remainder dd 0h
	number dd 0h
	Nbit dd 0h
	quotient dd 0h
	counter dd 0h
	num10 db 10
	num7 db 7
	minn db 0
	spacee db 3

.code

MulN proc
	push ebp
	mov ebp, esp
	mov esi, dword ptr[ebp + 16]
	mov edi, dword ptr[ebp + 12]
	mov ebx, dword ptr[ebp + 8]
	xor ecx, ecx
	xor edx, edx
	mov outer, 5
	.while outer > 0
		mov eax, dword ptr[esi + edx]
		push edx
		push ebx
		mov ebx, ecx
		sub ebx, edx
		mul dword ptr[edi + ebx]
		pop ebx
		add dword ptr[ebx + ecx], eax
		add dword ptr[ebx + ecx + 4], edx
		jnc @ncf
		xor eax, eax
		mov eax, ecx
		@cf:
			add eax, 4
			add dword ptr[ebx + eax + 4], 1
			jc @cf
		@ncf:
			pop edx
			add ecx, 4
			dec inner
			.if inner == 0
				add edx, 4
				mov ecx, edx
				mov inner, 5
				dec outer
			.endif
	.endw
	pop ebp
	ret 12
MulN endp

Mul32 proc
	push ebp
	mov ebp, esp
	mov esi, [ebp+16]
	mov ebx, [ebp+12]
	mov edi, [ebp+8]
	xor ecx, ecx
	.while ecx < 14
		mov eax, dword ptr[esi+ 4*ecx]
		mul ebx
		add dword ptr[edi+4*ecx], eax
		add dword ptr[edi+4*ecx+4], edx
		inc ecx
	.endw
	pop ebp
	ret 
Mul32 endp

DecString proc
	push ebp
	mov ebp,esp
	mov edx, [ebp+8]
	shr edx, 3
	mov esi, [ebp+12]
	mov edi, [ebp+16]
	mov eax, edx
	shl eax, 2
	mov cl, byte ptr[esi + edx - 1]
	and cl, 128
	.if cl != 128
		jmp @plus
	.endif
	mov minn, 1
	push edx
	.while edx > 0
		not byte ptr[esi + edx - 1]
		sub edx, 1
	.endw
	inc byte ptr[esi + edx]
	pop edx
@plus:
	.while edx > 0
		push edx
		call Div10
		pop edx
		add bh, 48
		mov byte ptr[edi + eax], bh
		dec eax
		.if bl != 0
			dec edx
		.endif
	.endw
	cmp minn, 1
	jc @nomin
	mov byte ptr[edi + eax + 1], 45
	dec eax
	@nomin:
		inc eax
	@space:
		mov byte ptr[edi + eax], 32
		sub eax, 1
		jnc @space
	pop ebp
	ret 12
DecString endp

Div10 proc
	xor ebx, ebx
	xor ecx, ecx
	dec edx
	.if byte ptr[esi + edx] == 0
		inc bl
	.endif
	@cycleout:
		mov ch, byte ptr[esi + edx]
		.while inner < 8
			shl cl, 1
			shl bh, 1
			shl ch, 1
			jnc @zero
			inc bh
		@zero:
			cmp bh, num10
			jc @less
			inc cl
			sub bh, num10
		@less:
			inc inner
			cmp inner, 8
		.endw
		mov byte ptr[esi + edx], cl
		mov inner, 0
		sub edx, 1
		jnc @cycleout
	ret
Div10 endp

f proc
	push ebp
        mov ebp, esp
        xor eax, eax
        xor ebx, ebx
        mov esi, [ebp+16] ; y
        mov eax, [ebp+12] ; x
        mov cl, [ebp+8]   ; m
        cdq
        mov ebx, 9
        idiv ebx
        shr eax, cl
        mov dword ptr[esi], eax
        mov esp, ebp
	pop ebp
	ret
f endp
End