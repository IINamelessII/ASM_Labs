.586
.model flat, stdcall

option casemap : none

include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\windows.inc
include module.inc
include longop.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib

.data

	Caption db "Lab6", 0
	
	Number dd 14 dup(0h)
	result dd 0h
	
	Text db ?
	Txt db 448 dup(0)
	
.code

start:

	mov dword ptr[Number+0], 11110111b
	mov dword ptr[Number+1], 11010110b
	mov dword ptr[Number+2], 01010101b
	mov dword ptr[Number+3], 11101011b
	;here 22 ones
	
	push offset Txt
	push offset Number
	push 448
	call StrHex_MY
	
	invoke MessageBoxA, 0, ADDR Txt, ADDR Caption, 0
	
	push offset Number
	push offset result
	call Count_Zeros
	;448-22=426=1AAh
	
	push offset Text
	push offset result
	push 16
	call StrHex_MY
	
	invoke MessageBoxA, 0, ADDR Text, ADDR Caption, 0
	
	invoke ExitProcess, 0
	
end start
