.586
.model flat, c

.data

	temp dd 0
	
.code

Count_Zeros proc

	push ebp
	mov ebp, esp
	mov esi, [ebp+12]
	mov edx, [ebp+8]
	xor eax, eax
	
	@cycle1:
	
		mov ebx, eax
		mov ecx, ebx
		shr ebx, 3
		and ecx, 07h
		mov al, 1
		shl al, cl
		mov ah, byte ptr[esi+ebx]
		and ah, al
		cmp ah, 0

		jne @cycle3
		jmp @cycle2
		
	@cycle2:
	
		add dword ptr[edx], 1h
		
	@cycle3:
	
		mov eax, temp
		inc eax
		mov temp, eax
		cmp eax, 448
		je @end
		jmp @cycle1
		
	@end:
	
		pop ebp
		ret 8
		
Count_Zeros endp

end
