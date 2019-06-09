.586
.model flat, c

.data 
	x dd 1
	n dd 0
.code

Mul32 proc
	push ebp
	mov ebp, esp
	mov edi, [ebp + 12]
	mov ebx, [ebp + 8]
	mov x, ebx
	mov n, 14
	xor ebx, ebx
	xor ecx, ecx
	.while n > 0	
		mov eax, dword ptr[edi + ecx]
		mul x
		mov dword ptr[edi + ecx], eax
		add dword ptr[edi + ecx], ebx
		mov ebx, edx
		add ecx, 4
		dec n
	.endw
	pop ebp
	ret 8
Mul32 endp

end