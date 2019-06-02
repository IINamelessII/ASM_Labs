.586
.model flat, stdcall
option casemap : none
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
include module.inc
include longop.inc

.data
	Caption1 db "Res = |A0B0 + A1B1 + ... + A7B7| Res=1721.05",  0
	Caption1Hex db "Res(HEX) = 409AE4334D6A161E", 0
	Caption2 db "Res = |A1B1 + A2B2 + A4B4 + A5B5 + A7B7| Res=1160.99",  0
	Caption2Hex db "Res(HEX) = 409223FAE147AE14", 0
	Caption3 db "Res = |A0B0 + A1B1 + A2B2 + A5B5 + A6B6| Res=816.70", 0
	Caption3Hex db "Res(HEX) = 408985919CE075F6", 0

	valA0 dq 1.01
	valB0 dq 10.01
	valA1 dq 1.1
	valB1 dq 11.11
	valA2 dq 2.2
	valB2 dq 22.22
	valA3 dq 3.3
	valB3 dq 33.33
	valA4 dq 4.4
	valB4 dq 44.44
	valA5 dq 5.5
	valB5 dq 55.55
	valA6 dq 6.6
	valB6 dq 66.66
	valA7 dq 7.7
	valB7 dq 77.77

	Res dq ?

	HexBuf dd 100 dup(?)
	DecBuf dd 100 dup(?)
	HexBuf2 dd 100 dup(?)
	DecBuf2 dd 100 dup(?)
	HexBuf3 dd 100 dup(?)
	DecBuf3 dd 100 dup(?)

.code

main :
    ;Res = |A0B0 + A1B1 + ... + A7B7|
	fld valA0
	fmul valB0

	fld valA1
	fmul valB1        
	faddp st(1), st(0)

	fld valA2
	fmul valB2
	faddp st(1), st(0)

	fld valA3
	fmul valB3
	faddp st(1), st(0)

	fld valA4
	fmul valB4
	faddp st(1), st(0)

	fld valA5
	fmul valB5
	faddp st(1), st(0)

	fld valA6
	fmul valB6
	faddp st(1), st(0)  

	fld valA7
	fmul valB7          
	faddp st(1), st(0)

	fabs               
	fstp Res           


	push offset DecBuf
	push offset Res
	call DecFloat64_LONGOP
invoke MessageBoxA, 0, ADDR DecBuf, ADDR Caption1, 0

	push offset HexBuf
	push offset Res
	push 64
	call HexString
invoke MessageBoxA, 0, ADDR HexBuf, ADDR Caption1Hex, 0


    ;Res = |A1B1 + A2B2 + A4B4 + A5B5 + A7B7|
	fld valA1
	fmul valB1

	fld valA2
	fmul valB2
	faddp st(1), st(0)

	fld valA4
	fmul valB4
	faddp st(1), st(0)

	fld valA5
	fmul valB5
	faddp st(1), st(0)

	fld valA7
	fmul valB7
	faddp st(1), st(0)

	fabs
	fstp Res


	push offset DecBuf2
	push offset Res
	call DecFloat64_LONGOP
invoke MessageBoxA, 0, ADDR DecBuf2, ADDR Caption2, 0

	push offset HexBuf2
	push offset Res
	push 64
	call HexString
invoke MessageBoxA, 0, ADDR HexBuf2, ADDR Caption2Hex, 0

    ;Res = |A0B0 + A1B1 + A2B2 + A5B5 + A6B6|
	fld valA0
	fmul valB0

	fld valA1
	fmul valB1
	faddp st(1), st(0)

	fld valA2
	fmul valB2
	faddp st(1), st(0)

	fld valA5
	fmul valB5
	faddp st(1), st(0)

	fld valA6
	fmul valB6
	faddp st(1), st(0)

	fabs
	fstp Res


	push offset DecBuf3
	push offset Res
	call DecFloat64_LONGOP
invoke MessageBoxA, 0, ADDR DecBuf3, ADDR Caption3, 0

	push offset HexBuf3
	push offset Res
	push 64
	call HexString
invoke MessageBoxA, 0, ADDR HexBuf3, ADDR Caption3Hex, 0

invoke ExitProcess, 0
end main
