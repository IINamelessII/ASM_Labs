.586
.model flat, stdcall

include C:\masm32\include\user32.inc
include C:\masm32\include\kernel32.inc

includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib

.data
	CaptionMain db "Hello World, I am not a Python program!", 0
	TextMain db "Hello World!", 13, 10, "Serikov Oleg, IV-72", 0
	res dd 256 dup(0)
	Text db 'EAX=xxxxxxxx',13,10,
					'EBX=xxxxxxxx',13,10,
					'ECX=xxxxxxxx',13,10,
					'EDX=xxxxxxxx',0
	Caption0 db "CPUID 0",0
	Caption1 db "CPUID 1",0
	Caption2 db "CPUID 2",0
	Caption00 db "CPUID 80000000h",0
	Caption01 db "CPUID 80000001h",0
	Caption02 db "CPUID 80000002h",0
	Caption03 db "CPUID 80000003h",0
	Caption04 db "CPUID 80000004h",0
	Caption05 db "CPUID 80000005h",0
	Caption08 db "CPUID 80000008h",0

.code
	;ця процедура записує 8 символів HEX коду числа
	;перший параметр - 32-бітове число
	;другий параметр - адреса буфера тексту
	DwordToStrHex proc
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8] ;другий параметр
	mov edx,[ebp+12] ;перший параметр
	xor eax,eax
	mov edi,7
	@next:
	mov al,dl
	and al,0Fh ;виділяємо одну шістнадцяткову цифру
	add ax,48 ;так можна тільки для цифр 0-9
	cmp ax,58
	jl @store
	add ax,7 ;для цифр A,B,C,D,E,F
	@store:
	mov [ebx+edi],al
	shr edx,4
	dec edi
	cmp edi,0
	jge @next
	pop ebp
	ret 8
	DwordToStrHex endp

start:
	invoke MessageBoxA, 0, ADDR TextMain, ADDR CaptionMain, 0

	mov eax, 0
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption0, 0

	mov eax, 1
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption1, 0
	mov eax, 2
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption2, 0
	mov eax, 80000000h
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]

	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption00, 0
	mov eax, 80000001h
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption01, 0
	mov eax, 80000002h
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption02, 0
	mov eax, 80000003h
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption03, 0
	mov eax, 80000004h

	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption04, 0
	mov eax, 80000005h
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption05, 0
	mov eax, 80000008h
	cpuid
	mov dword ptr[res], eax
	mov dword ptr[res+4], ebx
	mov dword ptr[res+8], ecx
	mov dword ptr[res+12], edx
	push [res] ;значення регістру EAX з масиву res
	push offset [Text+4] ;адреса, куди записуються 8 символів
	call DwordToStrHex
	push [res+4] ;значення регістру EBX з масиву res
	push offset [Text+18]
	call DwordToStrHex
	push [res+8] ;значення регістру ECX з масиву res
	push offset [Text+32]
	call DwordToStrHex
	push [res+12] ;значення регістру EDX з масиву res
	push offset [Text+46]
	call DwordToStrHex
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption08, 0

	invoke ExitProcess, 0
end start
