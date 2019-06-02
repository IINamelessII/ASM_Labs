 .586
.model flat, c

.data

	x dd 0
	n dd 0
	k dd 0
	temp dd 0
	innertemp dd 0
	mult dd 0
	shnum db 0
	oldshnum db 0
	bitnum db 0
	dwordmask dd 4294967295
	bytemask db 255
	extramask db 255
	cmpvar db 8
	eldermask dd 11100000000000000000000000000000b
	dwordcounter db 0
	checkbit dd 1
	sh_num db 0
	signdigit dq 1
	expmask dd 11111111111b
	mantmask1 dd 0
	mantmask2 dd 0
	int_part dq 0
	fract_part dq 0
	counter dd 0
	ten dd 10
	digitcounter dd 0
	accuracy db 0
.code

DecFloat64_LONGOP proc
	push ebp
	mov ebp, esp
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	mov dword ptr[signdigit], 1
	mov dword ptr[signdigit + 4], 0
	mov expmask, 11111111111b
	mov mantmask1, 0
	mov mantmask2, 0
	mov dword ptr[int_part], 0
	mov dword ptr[int_part + 4], 0
	mov dword ptr[fract_part], 0
	mov dword ptr[fract_part + 4], 0
	mov counter, 0
	mov ten, 10
	mov digitcounter, 0
	mov accuracy, 0
	mov esi, [ebp + 8]
	mov ebx, [ebp + 12]
	mov eax, 1
	shl eax, 31
	and eax, dword ptr[esi + 4]
	.if eax == 0
		jmp @plus
	.endif
	@minus:
		mov byte ptr[ebx], 45
		jmp @exponent
	@plus:
		mov byte ptr[ebx], 43
	@exponent:
		shl expmask, 20
		mov edx, expmask
		and edx, dword ptr[esi + 4]
		shr edx, 20
		sub edx, 1023
	@mantissa:
		mov counter, edx
		cmp counter, 20
		jg @more
	@less:
		shl mantmask1, 1
		inc mantmask1
		dec edx
		.if edx != 0
			jmp @less
		.endif
		mov cl, 20
		sub ecx, counter
		shl mantmask1, cl
		mov eax, mantmask1
		mov edx, 0
		and eax, dword ptr[esi + 4]
		shr eax, cl
		mov dword ptr[int_part], eax
		xor mantmask1, 4294967295
		shl mantmask1, 12
		shr mantmask1, 12
		xor mantmask2, 4294967295
		mov eax, mantmask2
		and eax, dword ptr[esi]
		mov dword ptr[fract_part], eax
		mov eax, mantmask1
		and eax, dword ptr[esi + 4]
		mov dword ptr[fract_part + 4], eax
		jmp @final
	@more:
		add mantmask1, 1048575
		sub edx, 20
		mov counter, edx
	@loop:
		shl mantmask2, 1
		inc mantmask2
		dec edx
		.if edx != 0
			jmp @loop
		.endif
		mov edx, 32
		sub edx, counter
	@loop2:
		shl mantmask2, 1
		dec edx
		.if edx != 0
			jmp @loop2
		.endif
		mov edx, mantmask1
		mov eax, mantmask2
		and edx, dword ptr[esi + 4]
		and eax, dword ptr[esi]
	@final:
		mov eax, dword ptr[int_part]
		mov ecx, counter
		mov edx, 1
		shl edx, cl
		add eax, edx
		mov edx, dword ptr[int_part + 4]
		xor ecx, ecx
	@checkdigitnum:
		div ten
		inc digitcounter
		mov edx, 0
		.if eax != 0
			jmp @checkdigitnum
		.endif
		mov eax, dword ptr[int_part]
		mov ecx, counter
		mov edx, 1
		shl edx, cl
		add eax, edx
		mov edx, dword ptr[int_part + 4]
		mov ecx, digitcounter
	@loop3:
		div ten
		add edx, 48
		mov byte ptr[ebx + ecx], dl
		dec ecx
		mov edx, 0
		.if eax != 0
			jmp @loop3
		.endif
		inc digitcounter
		mov ecx, digitcounter
		mov byte ptr[ebx + ecx], "."
		mov edx, dword ptr[fract_part + 4]
		mov eax, dword ptr[fract_part]
		mov expmask, 1111b
		mov ecx, 20
		sub ecx, counter
		shl expmask, cl
		mov counter, ecx
		mov accuracy, 6
		mov edi, 0
	@loop4:
		shl edx, 1
		shl eax, 1
		adc edx, 0
		mov dword ptr[fract_part + 4], edx
		mov dword ptr[fract_part], eax
		shl edx, 1
		shl eax, 1
		adc edx, 0
		shl edx, 1
		shl eax, 1
		adc edx, 0
		add eax, dword ptr[fract_part]
		adc edx, dword ptr[fract_part + 4]
		mov edi, expmask
		and edi, edx
		mov ecx, counter
		shr edi, cl
		add edi, 48
		mov ecx, digitcounter
		mov word ptr[ebx + ecx + 1], di
		inc digitcounter
		dec accuracy
		not expmask
		and edx, expmask
		not expmask
		.if accuracy != 0
			jmp @loop4
		.endif
	@exitp:
		pop ebp
		ret 8
DecFloat64_LONGOP endp

End