.386
.model flat, stdcall

include C:\masm32\include\user32.inc
include C:\masm32\include\kernel32.inc

includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib

.data
Caption db "Hello World, I am not a Python", 0
Text db "Hello World!", 13, 10,
"Serikov Oleg, IV-72", 0

.code
start:
    invoke MessageBoxA, 0, ADDR Text,
    ADDR Caption, 0
    invoke ExitProcess, 0

end start