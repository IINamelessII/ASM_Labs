.586
.model flat, stdcall

option casemap :none ;розрізнювати великі та маленькі букви
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include module.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib

.data
TextBuf db 64 dup(?)
Caption db "Lab3",0
Text db "Do you see this icons?", 10, 13, "its by Oleh Serikov!",0

value1 db 32
value2 db -32
value3 dw 32
value4 dw -32
value5 dd 32
value6 dd -32
value7 dq 32
value8 dq -32
value9 dd 32.0
value10 dd -32.0
value11 dd 32.32
value12 dq 32.0
value13 dq -64.0
value14 dq 32.32
value15 dt 32.0
value16 dt -64.0
value17 dt 32.32


.code

main:
invoke MessageBoxA, 0, ADDR Text, ADDR Caption, MB_ICONQUESTION

	push offset TextBuf
	push offset value1
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value2
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value3
	push 16
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value4
	push 16
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value5
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value6
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value7
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value8
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value9
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value10
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value11
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value12
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value13
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value14
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value15
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value16
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION

	push offset TextBuf
	push offset value17
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION


invoke ExitProcess, 0

end main
