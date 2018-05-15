PUBLIC	main

_TEXT	SEGMENT
IoStatusBlock$ = 96

main	PROC
	mov	ecx, -11				; fffffff5H
	;call GetStdHandle
	push rbx
	sub rsp, 32
	mov rax, QWORD PTR gs:[96]
	mov rcx, QWORD PTR [rax+32]
	mov rax, QWORD PTR gs:[96]
	mov rcx, QWORD PTR [rax+32]
	mov rbx, QWORD PTR [rcx+40] ; This effectively gets 0x4C (76)
	mov rax, rbx
	add rsp, 32
	pop rbx
	;end GetStdHandle
	mov	rcx, rax
	mov	QWORD PTR [rsp+64], 0
	mov	DWORD PTR [rsp+56], 0
	mov	eax, 19  ; 13
	mov	DWORD PTR [rsp+48], eax
	lea	rax, QWORD PTR pwned
	mov	QWORD PTR [rsp+40], rax
	lea	rax, QWORD PTR IoStatusBlock$[rsp]
	mov	QWORD PTR [rsp+32], rax
	xor	r9d, r9d
	xor	r8d, r8d
	xor	edx, edx
	;call NtWriteFile
	push rax  ; Fix stack alignment by adding 8 bytes
	mov r10, rcx
	mov eax, 8
	syscall
	pop rax  ; Undo fix
	ret
	;end NtWriteFile
	ret	0
main	ENDP

pwned:
	DB	'You''ve been pwned', 0dH, 0aH, 00H

_TEXT	ENDS
END

