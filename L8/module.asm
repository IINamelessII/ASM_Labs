.586
.model flat, c

.code

HexString proc
	push ebp
	mov ebp,esp
	mov ecx, [ebp+8]
	.if ecx <= 0
		jmp @exit
	.endif
	shr ecx, 3
	mov esi, [ebp+12]
	mov ebx, [ebp+16]
	.while ecx != 0
		mov dl, byte ptr[esi+ecx-1]
		mov al, dl
		shr al, 4
		call HexChar
		mov byte ptr[ebx], al
		mov al, dl
		call HexChar
		mov byte ptr[ebx+1], al
		mov eax, ecx
		.if eax <= 4
			jmp @next
		.endif
		dec eax
		and eax, 3
		.if al != 0
			jmp @next
		.endif
		mov byte ptr[ebx+2], 32
		inc ebx
		@next:
			add ebx, 2
			dec ecx
			.if ecx == 0
				mov byte ptr[ebx], 0
			.endif
	.endw
	@exit:
		pop ebp
		ret 12

HexString endp

HexChar proc
	and al, 0Fh
	add al, 48
	.if al < 58
		jmp @exit
	.endif
	add al, 7
	@exit:
		ret
HexChar endp

DwordToStrHex proc
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8]
	mov edx,[ebp+12]
	xor eax,eax
	mov edi,7
	.while edi >= 0
		mov al,dl
		and al,0Fh
		add ax,48
		.if ax < 58
			jmp @store
		.endif
		add ax,7
		@store:
			mov [ebx+edi],al
			shr edx,4
			dec edi
	.endw
	pop ebp
	ret 8
DwordToStrHex endp

end
