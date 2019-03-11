.586
.model flat, c
.code

Add_768_LONGOP proc
    push ebp
	mov ebp,esp

	mov esi, [ebp+16] ; ESI = адреса A
	mov ebx, [ebp+12] ; EBX = адреса B
	mov edi, [ebp+8] ; EDI = адреса результату

	mov ecx, 24 ; ECX = потрібна кількість повторень
	mov edx, 0
	clc ; обнулює біт CF регістру EFLAGS
	cycle:
	mov eax, dword ptr[esi+4*edx]
	adc eax, dword ptr[ebx+4*edx] ; додавання групи з 32 бітів
	mov dword ptr[edi+4*edx], eax

	inc edx
	dec ecx ; лічильник зменшуємо на 1
	jnz cycle
	pop ebp
	ret 12
Add_768_LONGOP endp

Sub_352_LONGOP proc
    push ebp
	mov ebp,esp

	mov esi, [ebp+16] ; ESI = адреса A
	mov ebx, [ebp+12] ; EBX = адреса B
	mov edi, [ebp+8] ; EDI = адреса результату

	mov ecx, 11 ; ECX = потрібна кількість повторень
	mov edx, 0
	clc ; обнулює біт CF регістру EFLAGS
	cycle:
	mov eax, dword ptr[esi+4*edx]
	sbb eax, dword ptr[ebx+4*edx] ; віднімання групи з 32 бітів
	mov dword ptr[edi+4*edx], eax

	inc edx
	dec ecx ; лічильник зменшуємо на 1
	jnz cycle
	pop ebp
	ret 12
Sub_352_LONGOP endp

End
