.586
.model flat, stdcall
option casemap : none
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\windows.inc 
include C:\masm32\include\comdlg32.inc  
includelib C:\masm32\lib\comdlg32.lib
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
include module.inc
include longop.inc

.data
    Caption0 db "L9", 0
    Text0 db "Good day, Viktor Nikolaevich!", 13, 10,
            ">>> variant", 13, 10,
			"(HEX, dynamic arrays)", 0
	Caption1 db "n!", 0
	n dd 1
	endofline db 13, 10
	hFile dd 0
	pVal dd ?
	pRes dd ?
	szFileName dd 64 dup(0)
	TextBuf db 448 dup(0)

.code
	MySaveFileName proc
		LOCAL ofn : OPENFILENAME
		invoke RtlZeroMemory, ADDR ofn, SIZEOF ofn
		mov ofn.lStructSize, SIZEOF ofn
		mov ofn.lpstrFile, offset szFileName
		mov ofn.nMaxFile, SIZEOF szFileName
		invoke GetSaveFileName, ADDR ofn
		ret
	MySaveFileName endp

	main:
	    invoke MessageBoxA, 0, ADDR Text0, ADDR Caption0, 0
		invoke GlobalAlloc, GPTR, 336
		mov pRes, eax ;set pointer of Res to 0
		mov dword ptr[eax], 1h
		call MySaveFileName
		.if eax == 0
			jmp @exit
		.endif
		invoke CreateFile, ADDR szFileName,
							GENERIC_WRITE,
							FILE_SHARE_WRITE,
							0, CREATE_ALWAYS,
							FILE_ATTRIBUTE_NORMAL,
							0
		.if eax == INVALID_HANDLE_VALUE
			jmp @exit
		.endif
		mov hFile, eax
		.while n <= 70
			push pRes
			push n
			call Mul32
			inc n
			
			push offset TextBuf
			push pRes
			push 336
			call HexString

			invoke WriteFile, hFile, ADDR TextBuf, 94, NULL, 0
			invoke WriteFile, hFile, ADDR endofline, 2, NULL, 0
		.endw
		invoke CloseHandle, hFile
		invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption1, 0
		@exit:
			invoke GlobalFree, pRes
			invoke ExitProcess, 0
	end main