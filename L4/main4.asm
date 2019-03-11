.586
.model flat, stdcall
option casemap :none
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\windows.inc
include module.inc
include longop.inc
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
.const
.data

.data
Caption1 db "A+B 1",0
Caption3 db "A+B 2",0
Caption2 db "A-B",0

TextBuf1 db 768 dup(?)
TextBuf3 db 768 dup(?)
TextBuf2 db 352 dup(?)

ValueA1 dd 768 dup(?) 
ValueB1 dd 768 dup(?) 
ValueA3 dd 768 dup(?) 
ValueB3 dd 768 dup(?)
ValueA2 dd 352 dup(?) 
ValueB2 dd 352 dup(?) 

Result1 dd 768 dup(0)
Result3 dd 768 dup(0)
Result2 dd 352 dup(0)  

.code
main:

;A+B 1
mov eax, 80010001h
mov ecx, 24   ; ECX = потрібна кількість повторень
mov edx, 0
cycleAB1:	
mov DWord ptr[ValueA1+4*edx], eax
mov DWord ptr[ValueB1+4*edx], 80000001h
add eax, 10000h
inc edx
dec ecx        ; зменшуємо лічильник на 1 
jnz cycleAB1

push offset ValueA1
push offset ValueB1
push offset Result1
call Add_768_LONGOP
push offset TextBuf1 
push offset Result1
push 768
call StrHex_MY 
invoke MessageBoxA, 0, ADDR TextBuf1, ADDR Caption1,0

;A+B 2
mov eax, 3h
mov ecx, 24   ; ECX = потрібна кількість повторень
mov edx,0
cycleAB3:	
mov DWord ptr[ValueA3+4*edx], eax
mov DWord ptr[ValueB3+4*edx], 00000001h
add eax, 1h
inc edx
dec ecx        ; зменшуємо лічильник на 1 
jnz cycleAB3

push offset ValueA3
push offset ValueB3
push offset Result3
call Add_768_LONGOP
push offset TextBuf3 
push offset Result3
push 768
call StrHex_MY 
invoke MessageBoxA, 0, ADDR TextBuf3, ADDR Caption3,0

;A-B 
mov eax, 3h  
mov ecx, 11   ; ECX = потрібна кількість повторень
mov edx,0
cycleAB2:	
mov DWord ptr[ValueA2+4*edx], 0
mov DWord ptr[ValueB2+4*edx], eax
add eax, 1h
inc edx
dec ecx        ; зменшуємо лічильник на 1  
jnz cycleAB2

push offset ValueA2
push offset ValueB2
push offset Result2
call Sub_352_LONGOP
push offset TextBuf2 
push offset Result2
push 352
call StrHex_MY 
invoke MessageBoxA, 0, ADDR TextBuf2, ADDR Caption2,0


invoke ExitProcess, 0
end main
