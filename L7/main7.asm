.586
.model flat, stdcall
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
include module.inc
include longop.inc

.data
    varA dd 1h, 13 dup(0h)
    factorial dd 1h
    temp dd 14 dup(0h)
    result dd 0h
    count dd 0h
    Caption1 db "70! HEX", 0
    Caption2 db "70! DEC", 0
    Caption3 db "(4096/9)*2^-6", 0
    TextBuff1 db 448 dup(?)
    TextBuff2 db 448 dup(?)
    TextBuff3 db 16 dup(?)

.code
main:
    .while count < 70
        push offset varA
        push factorial
        push offset temp
        call Mul32
        inc factorial
        mov ecx, 12
        .while ecx > 0
            mov ebx, dword ptr[temp+4*ecx-4]
            mov dword ptr[varA+4*ecx-4], ebx
            mov dword ptr[temp+4*ecx-4], 0
            dec ecx
        .endw
        inc count
    .endw
    push offset TextBuff1
    push offset varA
    push 336
    call HexString
    invoke MessageBoxA, 0, ADDR TextBuff1, ADDR Caption1, 0
    push offset TextBuff2
    push offset varA
    push 352
    call DecString
    invoke MessageBoxA, 0, ADDR TextBuff2, ADDR Caption2, 0
    push offset result
    push 4096   ; x
    push 6      ; m
    call f
    push offset TextBuff3
    push offset result
    push 32
    call DecString
    invoke MessageBoxA, 0, ADDR TextBuff3, ADDR Caption3, 0
    invoke ExitProcess, 0
end main